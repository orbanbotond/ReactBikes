import {
  FETCH_BIKES,
  FETCH_BIKES_SUCCESS,
  FETCH_BIKES_ERROR,
  FETCH_MODELS,
  FETCH_MODELS_SUCCESS,
  FETCH_MODELS_ERROR,
} from './action-creators';

const bikesDefaultState = { loading: false, bikes: null, errors: null };

export const bikesReducer = (state = bikesDefaultState, action) => {
  switch (action.type) {
    case FETCH_BIKES:
      return { loading: true, bikes: null, errors: null };
    case FETCH_BIKES_SUCCESS:
      return { loading: false, bikes: action.payload, errors: null };
    case FETCH_BIKES_ERROR:
      return { loading: false, bikes: null, errors: action.payload };
    default:
      return state;
  }
};

const bikeModelsDefaultState = { loading: false, models: null, errors: null };

export const bikeModelReducer = (state = bikeModelsDefaultState, action) => {
  switch (action.type) {
    case FETCH_MODELS:
      return { loading: true, models: null, errors: null };
    case FETCH_MODELS_SUCCESS:
      return { loading: false, models: action.payload, errors: null };
    case FETCH_MODELS_ERROR:
      return { loading: false, models: null, errors: action.payload };
    default:
      return state;
  }
};
