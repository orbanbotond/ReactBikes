import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import { sessionReducer } from 'redux-react-session';
import { reducers as bike } from '@modules/bikes';

const combined = combineReducers({
  form: formReducer,
  session: sessionReducer,
  bikes: bike.bikesReducer,
  models: bike.bikeModelReducer,
});

export default combined;
