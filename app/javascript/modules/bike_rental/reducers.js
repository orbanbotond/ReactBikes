import {
  FETCH_SEARCH_RESULTS,
  FETCH_SEARCH_RESULTS_SUCCESS,
  FETCH_SEARCH_RESULTS_ERROR,
} from './action-creators';

const searchResultsDefaultState = { loading: false, collection: null, errors: null };

export const searchResultReducer = (state = searchResultsDefaultState, action) => {
  switch (action.type) {
    case FETCH_SEARCH_RESULTS:
      return { loading: true, collection: null, errors: null };
    case FETCH_SEARCH_RESULTS_SUCCESS:
      return { loading: false, collection: action.payload, errors: null };
    case FETCH_SEARCH_RESULTS_ERROR:
      return { loading: false, collection: null, errors: action.payload };
    default:
      return state;
  }
};
