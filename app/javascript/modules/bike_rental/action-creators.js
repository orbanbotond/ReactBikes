/* eslint-env browser */
import { BikesAxios as Axios } from '@routes/routes';
import { Routes } from '@routes/routes';

// TODO change this boylerplace code to something generic.
export const FETCH_SEARCH_RESULTS = 'FETCH_SEARCH_RESULTS';
export const FETCH_SEARCH_RESULTS_SUCCESS = 'FETCH_SEARCH_RESULTS_SUCCESS';
export const FETCH_SEARCH_RESULTS_ERROR = 'FETCH_SEARCH_RESULTS_ERROR';

export const fetchSearchResults = () => ({
  type: FETCH_SEARCH_RESULTS,
});

export const fetchSearchResultsSuccess = data => ({
  type: FETCH_SEARCH_RESULTS_SUCCESS,
  payload: data,
});

export const fetchSearchResultsError = error => ({
  type: FETCH_SEARCH_RESULTS_ERROR,
  payload: error,
});

export function fetchTheSearchResults(data) {
  return function (dispatch, getState) {
    dispatch(fetchSearchResults());

    const currentUser = getState().session.user;
    const url = Routes.Queries.available_bikes();

    return Axios(currentUser).get(url, { params: data }).then((responseObj) => {
      dispatch(fetchSearchResultsSuccess(responseObj.data));
    }).catch((error) => {
      dispatch(fetchSearchResultsError(error));
    });
  };
}
