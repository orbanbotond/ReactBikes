import { sessionService } from 'redux-react-session';

export const LOGOUT = 'LOGOUT';
export const LOGIN = 'LOGIN';

export const logout = () => {
  sessionService.deleteUser()
    .then(() => sessionService.deleteSession());

  return ({
    type: LOGOUT,
  });
};

export const login = (currentUser) => {
  sessionService.saveSession({ token: currentUser.auth_token });
  sessionService.saveUser(currentUser);

  return ({
    type: LOGIN,
    payload: currentUser,
  });
};
