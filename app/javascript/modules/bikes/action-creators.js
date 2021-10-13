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
    const query = `
    {
      bikes{
        nodes{
          id,
          color,
          weight,
          imageUrl,
          averageRating,
          latitude,
          longitude,
          model{
            id,
            text
          },
        }
      }
    }
    `

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((responseObj) => {
      const bikes = responseObj.data.data.bikes.nodes.map(bike=> ({
        ...bike,
        bike_model_id: bike.model.id
      }));
      dispatch(fetchBikesSuccess(bikes));
    }).catch((error) => {
      dispatch(fetchBikesError(error));
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

    const query = `
      query BikeModels{
        bikeModels{
          id,
          text
        }
      }
    `

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((responseObj) => {
      const bikeModels = responseObj.data.data.bikeModels;

      dispatch(fetchModelsSuccess(bikeModels));
    }).catch((error) => {
      dispatch(fetchModelsError(error));
    });
  };
}

export function deleteTheBike(id) {
  return function (dispatch, getState) {
    const currentUser = getState().session.user;

    const query = `
      mutation DeleteBike($bikeId: ID!){
        deleteBike(input: {bikeId: $bikeId}){
          errors,
        }
      }
    `
    const variables = `
      {
        "bikeId": "${id}"
      }
    `

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query, variables: variables}).then(() => {
      dispatch(fetchTheBikes());
    }).catch(() => {
    });
  };
}
