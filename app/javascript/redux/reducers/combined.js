import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import { sessionReducer } from 'redux-react-session';

const combined = combineReducers({
  form: formReducer,
  session: sessionReducer,
});

export default combined;
