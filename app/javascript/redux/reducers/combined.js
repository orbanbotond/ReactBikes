import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import { sessionReducer } from 'redux-react-session';
import { reducers as bike } from '@modules/bikes';
import { reducers as user } from '@modules/users';
import { reducers as searchResults } from '@modules/bike_rental';

const combined = combineReducers({
  form: formReducer,
  session: sessionReducer,
  bikes: bike.bikesReducer,
  models: bike.bikeModelReducer,
  searchResults: searchResults.searchResultReducer,
  users: user.usersReducer,
});

export default combined;
