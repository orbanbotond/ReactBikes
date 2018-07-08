import {
  FETCH_BIKES,
  FETCH_BIKES_SUCCESS,
  FETCH_BIKES_ERROR,
  FETCH_MODELS,
  FETCH_MODELS_SUCCESS,
  FETCH_MODELS_ERROR,
} from './action-creators';

const bikesDefaultState = { loading: false, collection: null, errors: null };

export const bikesReducer = (state = bikesDefaultState, action) => {
  switch (action.type) {
    case FETCH_BIKES:
      return { loading: true, collection: null, errors: null };
    case FETCH_BIKES_SUCCESS:
      return { loading: false, collection: action.payload, errors: null };
    case FETCH_BIKES_ERROR:
      return { loading: false, collection: null, errors: action.payload };
    default:
      return state;
  }
};

const bikeModelsDefaultState = { loading: false, collection: null, errors: null };

export const bikeModelReducer = (state = bikeModelsDefaultState, action) => {
  switch (action.type) {
    case FETCH_MODELS:
      return { loading: true, collection: null, errors: null };
    case FETCH_MODELS_SUCCESS:
      return { loading: false, collection: action.payload, errors: null };
    case FETCH_MODELS_ERROR:
      return { loading: false, collection: null, errors: action.payload };
    default:
      return state;
  }
};
