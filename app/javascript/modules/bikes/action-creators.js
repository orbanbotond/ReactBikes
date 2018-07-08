/* eslint-env browser */
import { BikesAxios as Axios } from '@routes/routes';
import { Routes } from '@routes/routes';

// TODO change this boylerplace code to something generic.
export const FETCH_BIKES = 'FETCH_BIKES';
export const FETCH_BIKES_SUCCESS = 'FETCH_BIKES_SUCCESS';
export const FETCH_BIKES_ERROR = 'FETCH_BIKES_ERROR';

export const fetchBikes = () => ({
  type: FETCH_BIKES,
});

export const fetchBikesSuccess = data => ({
  type: FETCH_BIKES_SUCCESS,
  payload: data,
});

export const fetchBikesError = error => ({
  type: FETCH_BIKES_ERROR,
  payload: error,
});

export function fetchTheBikes() {
  return function (dispatch, getState) {
    dispatch(fetchBikes());

    const currentUser = getState().session.user;
    const url = Routes.Restfull.collection_route('bike');

    return Axios(currentUser).get(url).then((_responseObj) => {
      dispatch(fetchBikesSuccess(_responseObj.data));
    }).catch((_error) => {
      dispatch(fetchBikesError(_error));
    });
  };
}

export const FETCH_MODELS = 'FETCH_MODELS';
export const FETCH_MODELS_SUCCESS = 'FETCH_MODELS_SUCCESS';
export const FETCH_MODELS_ERROR = 'FETCH_MODELS_ERROR';

export const fetchModels = () => ({
  type: FETCH_MODELS,
});

export const fetchModelsSuccess = data => ({
  type: FETCH_MODELS_SUCCESS,
  payload: data,
});

export const fetchModelsError = error => ({
  type: FETCH_MODELS_ERROR,
  payload: error,
});

export function fetchTheModels() {
  return function (dispatch, getState) {
    dispatch(fetchModels());

    const currentUser = getState().session.user;
    const url = Routes.Restfull.collection_route('bike_model');

    return Axios(currentUser).get(url).then((_responseObj) => {
      dispatch(fetchModelsSuccess(_responseObj.data));
    }).catch((_error) => {
      dispatch(fetchModelsError(_error));
    });
  };
}
