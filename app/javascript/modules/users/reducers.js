import {
  FETCH_USERS,
  FETCH_USERS_SUCCESS,
  FETCH_USERS_ERROR,
} from './action-creators';

const bikesDefaultState = { loading: false, collection: null, errors: null };

export const usersReducer = (state = bikesDefaultState, action) => {
  switch (action.type) {
    case FETCH_USERS:
      return { loading: true, collection: null, errors: null };
    case FETCH_USERS_SUCCESS:
      return { loading: false, collection: action.payload, errors: null };
    case FETCH_USERS_ERROR:
      return { loading: false, collection: null, errors: action.payload };
    default:
      return state;
  }
};
