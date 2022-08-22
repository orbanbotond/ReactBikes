"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
Object.defineProperty(exports, "Star", {
  enumerable: true,
  get: function get() {
    return _star["default"];
  }
});
exports["default"] = void 0;

var _react = _interopRequireWildcard(require("react"));

var _propTypes = _interopRequireDefault(require("prop-types"));

var _star = _interopRequireDefault(require("./star"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function _getRequireWildcardCache() { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj["default"] = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

(function () {
  var enterModule = typeof reactHotLoaderGlobal !== 'undefined' ? reactHotLoaderGlobal.enterModule : undefined;
  enterModule && enterModule(module);
})();

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

function _objectWithoutProperties(source, excluded) { if (source == null) return {}; var target = _objectWithoutPropertiesLoose(source, excluded); var key, i; if (Object.getOwnPropertySymbols) { var sourceSymbolKeys = Object.getOwnPropertySymbols(source); for (i = 0; i < sourceSymbolKeys.length; i++) { key = sourceSymbolKeys[i]; if (excluded.indexOf(key) >= 0) continue; if (!Object.prototype.propertyIsEnumerable.call(source, key)) continue; target[key] = source[key]; } } return target; }

function _objectWithoutPropertiesLoose(source, excluded) { if (source == null) return {}; var target = {}; var sourceKeys = Object.keys(source); var key, i; for (i = 0; i < sourceKeys.length; i++) { key = sourceKeys[i]; if (excluded.indexOf(key) >= 0) continue; target[key] = source[key]; } return target; }

function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys(source, true).forEach(function (key) { _defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys(source).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

var __signature__ = typeof reactHotLoaderGlobal !== 'undefined' ? reactHotLoaderGlobal["default"].signature : function (a) {
  return a;
};

var Rater =
/*#__PURE__*/
function (_Component) {
  _inherits(Rater, _Component);

  function Rater(props) {
    var _this;

    _classCallCheck(this, Rater);

    _this = _possibleConstructorReturn(this, _getPrototypeOf(Rater).call(this, props));
    _this.state = {
      rating: props.rating,
      lastRating: props.rating,
      isRating: false
    };
    return _this;
  }

  _createClass(Rater, [{
    key: "willRate",
    value: function willRate(rating, e) {
      this.setState({
        rating: rating,
        isRating: true
      });
      var callback = this.props.onRating;
      callback && callback(_objectSpread({}, e, {
        rating: rating
      }));
    }
  }, {
    key: "onRate",
    value: function onRate(rating, e) {
      this.setState({
        rating: rating,
        lastRating: rating,
        isRating: false
      });
      var callback = this.props.onRate;
      callback && callback(_objectSpread({}, e, {
        rating: rating
      }));
    }
  }, {
    key: "onCancelRate",
    value: function onCancelRate() {
      var rating = this.state.lastRating;
      this.setState({
        rating: rating,
        isRating: false
      });
      var callback = this.props.onCancelRate;
      callback && callback({
        rating: rating
      });
    }
  }, {
    key: "UNSAFE_componentWillReceiveProps",
    value: function UNSAFE_componentWillReceiveProps(nextProps, props) {
      var rating = nextProps.rating;

      if (rating !== props.rating) {
        this.setState({
          rating: rating,
          lastRating: rating
        });
      }
    }
  }, {
    key: "render",
    value: function render() {
      var _this2 = this;

      var _this$props = this.props,
          total = _this$props.total,
          interactive = _this$props.interactive,
          children = _this$props.children,
          restProps = _objectWithoutProperties(_this$props, ["total", "interactive", "children"]);

      var _this$state = this.state,
          rating = _this$state.rating,
          isRating = _this$state.isRating;
      children = _react.Children.toArray(children);
      delete restProps.rating;
      delete restProps.onRate;
      delete restProps.onRating;
      delete restProps.onCancelRate;
      var nodes = Array.apply(null, Array(total)).map(function (_, i) {
        var starProps = {
          isActive: !isRating && rating - i >= 1,
          willBeActive: isRating && i < rating,
          isActiveHalf: !isRating && rating - i >= 0.5 && rating - i < 1,
          isDisabled: !interactive
        };
        return _react["default"].createElement("div", {
          key: "star-".concat(i),
          onClick: interactive ? _this2.onRate.bind(_this2, i + 1) : null,
          onMouseOver: interactive ? _this2.willRate.bind(_this2, i + 1) : null
        }, children.length ? _react["default"].cloneElement(children[i % children.length], starProps) : _react["default"].createElement(_star["default"], starProps));
      });

      if (interactive) {
        return _react["default"].createElement("div", _extends({
          className: "react-rater",
          onMouseOut: this.onCancelRate.bind(this)
        }, restProps), nodes);
      } else {
        return _react["default"].createElement("div", _extends({
          className: "react-rater"
        }, restProps), nodes);
      }
    }
  }, {
    key: "__reactstandin__regenerateByEval",
    // @ts-ignore
    value: function __reactstandin__regenerateByEval(key, code) {
      // @ts-ignore
      this[key] = eval(code);
    }
  }]);

  return Rater;
}(_react.Component);

exports["default"] = Rater;
Rater.propTypes = {
  total: _propTypes["default"].number,
  rating: _propTypes["default"].number,
  interactive: _propTypes["default"].bool,
  children: _propTypes["default"].any,
  onRate: _propTypes["default"].func,
  onRating: _propTypes["default"].func,
  onCancelRate: _propTypes["default"].func
};
Rater.defaultProps = {
  total: 5,
  rating: 0,
  interactive: true
};
;

(function () {
  var reactHotLoader = typeof reactHotLoaderGlobal !== 'undefined' ? reactHotLoaderGlobal.default : undefined;

  if (!reactHotLoader) {
    return;
  }

  reactHotLoader.register(Rater, "Rater", "/Users/simon/Individual/react-rater/src/index.js");
})();

;

(function () {
  var leaveModule = typeof reactHotLoaderGlobal !== 'undefined' ? reactHotLoaderGlobal.leaveModule : undefined;
  leaveModule && leaveModule(module);
})();