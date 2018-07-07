/* eslint-env browser */

import ReactDOM from 'react-dom';
import React from 'react';
import { Provider } from 'react-redux';

import { sessionService } from 'redux-react-session';

import store from '@redux/store/app-state';
import App from './app';

sessionService.initSessionService(store).then(() => {
  const Main = () => (
    <Provider store={store}>
      <App />
    </Provider>
  );

  ReactDOM.render(React.createElement(Main), document.getElementById('content'));
});
