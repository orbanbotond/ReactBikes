import {
  FETCH_USERS,
  FETCH_USERS_SUCCESS,
  FETCH_USERS_ERROR,
} from './action-creators';

const bikesDefaultState = { loading: false, users: null, errors: null };

export const usersReducer = (state = bikesDefaultState, action) => {
  switch (action.type) {
    case FETCH_USERS:
      return { loading: true, users: null, errors: null };
    case FETCH_USERS_SUCCESS:
      return { loading: false, users: action.payload, errors: null };
    case FETCH_USERS_ERROR:
      return { loading: false, users: null, errors: action.payload };
    default:
      return state;
  }
};
