/* eslint-env browser */
import { BikesAxios as Axios } from '@routes/routes';
import { Routes } from '@routes/routes';

// TODO change this boylerplace code to something generic.
export const FETCH_USERS = 'FETCH_USERS';
export const FETCH_USERS_SUCCESS = 'FETCH_USERS_SUCCESS';
export const FETCH_USERS_ERROR = 'FETCH_USERS_ERROR';

export const fetchUsers = () => ({
  type: FETCH_USERS,
});

export const fetchUsersSuccess = data => ({
  type: FETCH_USERS_SUCCESS,
  payload: data,
});

export const fetchUsersError = error => ({
  type: FETCH_USERS_ERROR,
  payload: error,
});

export function fetchTheUsers() {
  return function (dispatch, getState) {
    dispatch(fetchUsers());

    const currentUser = getState().session.user;
    const url = Routes.Restfull.collection_route('user');

    return Axios(currentUser).get(url).then((_responseObj) => {
      dispatch(fetchUsersSuccess(_responseObj.data));
    }).catch((_error) => {
      dispatch(fetchUsersError(_error));
    });
  };
}

export function deleteTheUser(id) {
  return function (dispatch, getState) {
    const currentUser = getState().session.user;
    const url = Routes.Restfull.member_route('user', id);

    return Axios(currentUser).delete(url).then((_responseObj) => {
      dispatch(fetchTheUsers());
    }).catch((_error) => {
    });
  };
}
