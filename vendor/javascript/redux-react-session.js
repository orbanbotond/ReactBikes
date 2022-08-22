'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.sessionReducer = exports.sessionService = undefined;

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _constants = require('./constants');

var _jsCookie = require('js-cookie');

var Cookies = _interopRequireWildcard(_jsCookie);

var _isPromise = require('is-promise');

var _isPromise2 = _interopRequireDefault(_isPromise);

var _actions = require('./actions');

var _reducer = require('./reducer');

var _reducer2 = _interopRequireDefault(_reducer);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var instance = void 0;

var sessionService = exports.sessionService = function () {
  function sessionService(store, options) {
    _classCallCheck(this, sessionService);

    instance = this;
    sessionService.setOptions(store, options);
    return instance;
  }

  _createClass(sessionService, null, [{
    key: 'setOptions',
    value: function setOptions(store) {
      var _ref = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
          driver = _ref.driver,
          validateSession = _ref.validateSession,
          _ref$refreshOnCheckAu = _ref.refreshOnCheckAuth,
          refreshOnCheckAuth = _ref$refreshOnCheckAu === undefined ? false : _ref$refreshOnCheckAu,
          _ref$expires = _ref.expires,
          expires = _ref$expires === undefined ? 360 : _ref$expires,
          _ref$redirectPath = _ref.redirectPath,
          redirectPath = _ref$redirectPath === undefined ? 'login' : _ref$redirectPath,
          _ref$server = _ref.server,
          server = _ref$server === undefined ? false : _ref$server;

      instance.store = store;
      instance.refreshOnCheckAuth = refreshOnCheckAuth;
      instance.redirectPath = redirectPath;
      instance.expires = expires;
      instance.driver = driver;
      instance.server = server;
      instance.validateSession = validateSession;

      // configure the storage
      var storageOptions = {
        name: 'redux-react-session'
      };
      var localforage = require('localforage');
      if (driver && driver !== 'COOKIES') {
        storageOptions.driver = localforage[driver];
      }
      instance.storage = localforage.createInstance(storageOptions);
    }
  }, {
    key: 'initSessionService',
    value: function initSessionService(store, options) {
      instance = new sessionService(store, options);
      return sessionService.refreshFromLocalStorage();
    }
  }, {
    key: 'initServerSession',
    value: function initServerSession(store, req, options) {
      instance = new sessionService(store, _extends({}, options, { server: true }));
      var parseCookies = function parseCookies(req) {
        var list = {};
        var rc = req.get('cookie');
        rc && rc.split(';').forEach(function (cookie) {
          var parts = cookie.split('=');
          if (parts[0].trim() === _constants.USER_SESSION || parts[0].trim() === _constants.USER_DATA) {
            list[parts[0].trim()] = JSON.parse(decodeURIComponent(parts[1]));
          }
        });

        return list;
      };
      return sessionService.saveFromClient(parseCookies(req));
    }
  }, {
    key: 'saveFromClient',
    value: function saveFromClient(cookies) {
      return new Promise(function (resolve, reject) {
        if (cookies[_constants.USER_SESSION]) {
          sessionService.saveSession(cookies[_constants.USER_SESSION]).then(function () {
            if (cookies[_constants.USER_DATA]) {
              sessionService.saveUser(cookies[_constants.USER_DATA]).then(function () {
                return resolve();
              });
            } else {
              return resolve();
            }
          });
        } else {
          instance.store.dispatch((0, _actions.getSessionError)());
          reject('Session not found');
        }
      });
    }
  }, {
    key: 'invalidateSession',
    value: function invalidateSession() {
      instance.store.dispatch((0, _actions.invalidSession)());
      sessionService.deleteSession();
      sessionService.deleteUser();
    }
  }, {
    key: 'attemptLoadUser',
    value: function attemptLoadUser() {
      instance.store.dispatch((0, _actions.getSessionSuccess)());
      return sessionService.loadUser().then(function (user) {
        instance.store.dispatch((0, _actions.getUserSessionSuccess)(user));
      }).catch(function () {
        instance.store.dispatch((0, _actions.getUserSessionError)());
      });
    }
  }, {
    key: 'refreshFromLocalStorage',
    value: function refreshFromLocalStorage() {
      var _this = this;

      return sessionService.loadSession().then(function (session) {
        if (instance.validateSession) {
          var value = instance.validateSession(session);

          if ((0, _isPromise2.default)(value)) {
            return value.then(function (valid) {
              if (!valid) {
                throw new Error("Session is invalid");
              }
              return _this.attemptLoadUser();
            }).catch(function () {
              _this.invalidateSession();
            });
          } else if (!value) {
            _this.invalidateSession();
            return;
          }
        }
        return _this.attemptLoadUser();
      }).catch(function () {
        instance.store.dispatch((0, _actions.getSessionError)());
      });
    }
  }, {
    key: 'checkAuth',
    value: function checkAuth(nextState, replace, next) {
      var _instance = instance,
          refreshOnCheckAuth = _instance.refreshOnCheckAuth,
          store = _instance.store;

      sessionService.loadSession().then(function () {
        refreshOnCheckAuth && store.dispatch((0, _actions.getSessionSuccess)());
        sessionService.loadUser().then(function (user) {
          refreshOnCheckAuth && store.dispatch((0, _actions.getUserSessionSuccess)(user));
          next();
        }).catch(function () {
          return next();
        });
      }).catch(function () {
        refreshOnCheckAuth && store.dispatch((0, _actions.getSessionError)());
        refreshOnCheckAuth && store.dispatch((0, _actions.getUserSessionError)());
        replace({
          pathname: instance.redirectPath,
          state: { nextPathname: nextState.location.pathname }
        });
        next();
      });
    }
  }, {
    key: 'saveSession',
    value: function saveSession(session) {
      return new Promise(function (resolve) {
        if (instance.server) {
          instance[_constants.USER_SESSION] = session;
          instance.store.dispatch((0, _actions.getSessionSuccess)());
          resolve();
        } else if (instance.driver === 'COOKIES') {
          Cookies.set(_constants.USER_SESSION, session, { expires: instance.expires });
          instance.store.dispatch((0, _actions.getSessionSuccess)());
          resolve();
        } else {
          instance.storage.setItem(_constants.USER_SESSION, session).then(function () {
            instance.store.dispatch((0, _actions.getSessionSuccess)());
            resolve();
          }).catch(function () {
            Cookies.set(_constants.USER_SESSION, session, { expires: instance.expires });
            instance.store.dispatch((0, _actions.getSessionSuccess)());
            resolve();
          });
        }
      });
    }
  }, {
    key: 'loadSession',
    value: function loadSession() {
      return new Promise(function (resolve, reject) {
        if (instance.server) {
          instance[_constants.USER_SESSION] ? resolve(instance[_constants.USER_SESSION]) : reject();
        } else if (instance.driver === 'COOKIES') {
          var cookies = Cookies.getJSON(_constants.USER_SESSION);
          cookies ? resolve(cookies) : reject('Session not found');
        } else {
          instance.storage.getItem(_constants.USER_SESSION).then(function (currentSession) {
            if (currentSession) {
              resolve(currentSession);
            } else {
              var _cookies = Cookies.getJSON(_constants.USER_SESSION);
              _cookies ? resolve(_cookies) : reject('Session not found');
            }
          }).catch(function (err) {
            return reject(err);
          });
        }
      });
    }
  }, {
    key: 'deleteSession',
    value: function deleteSession() {
      return instance.storage.removeItem(_constants.USER_SESSION).then(function () {
        instance.store.dispatch((0, _actions.getSessionError)());
        Cookies.remove(_constants.USER_SESSION);
        delete instance[_constants.USER_SESSION];
      });
    }
  }, {
    key: 'saveUser',
    value: function saveUser(user) {
      return new Promise(function (resolve) {
        if (instance.server) {
          instance[_constants.USER_DATA] = user;
          instance.store.dispatch((0, _actions.getUserSessionSuccess)(user));
          resolve();
        } else if (instance.driver === 'COOKIES') {
          Cookies.set(_constants.USER_DATA, user, { expires: instance.expires });
          instance.store.dispatch((0, _actions.getUserSessionSuccess)(user));
          resolve();
        } else {
          instance.storage.setItem(_constants.USER_DATA, user).then(function (user) {
            instance.store.dispatch((0, _actions.getUserSessionSuccess)(user));
            resolve();
          }).catch(function () {
            instance.store.dispatch((0, _actions.getUserSessionSuccess)(user));
            Cookies.set(_constants.USER_DATA, user, { expires: instance.expires });
            resolve();
          });
        }
      });
    }
  }, {
    key: 'loadUser',
    value: function loadUser() {
      return new Promise(function (resolve, reject) {
        if (instance.server) {
          instance[_constants.USER_DATA] ? resolve(instance[_constants.USER_DATA]) : reject();
        } else if (instance.driver === 'COOKIES') {
          var cookies = Cookies.getJSON(_constants.USER_DATA);
          cookies ? resolve(cookies) : reject('User not found');
        } else {
          instance.storage.getItem(_constants.USER_DATA).then(function (currentUser) {
            if (currentUser) {
              resolve(currentUser);
            } else {
              var _cookies2 = Cookies.getJSON(_constants.USER_DATA);
              _cookies2 ? resolve(_cookies2) : reject('User not found');
            }
          }).catch(function (err) {
            return reject(err);
          });
        }
      });
    }
  }, {
    key: 'deleteUser',
    value: function deleteUser() {
      return instance.storage.removeItem(_constants.USER_DATA).then(function () {
        instance.store.dispatch((0, _actions.getUserSessionError)());
        Cookies.remove(_constants.USER_DATA);
        delete instance[_constants.USER_DATA];
      });
    }
  }]);

  return sessionService;
}();

var sessionReducer = exports.sessionReducer = _reducer2.default;