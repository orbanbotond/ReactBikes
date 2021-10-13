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

    const query = `
    {
      users{
        nodes{
          id,
          email,
          admin
        }
      }
    }
    `

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((_responseObj) => {
      const users = _responseObj.data.data.users.nodes;
      dispatch(fetchUsersSuccess(users));
    }).catch((_error) => {
      dispatch(fetchUsersError(_error));
    });
  };
}

export function deleteTheUser(id) {
  return function (dispatch, getState) {
    const currentUser = getState().session.user;
    const url = Routes.Restfull.member_route('user', id);

    return Axios(currentUser).delete(url).then(() => {
      dispatch(fetchTheUsers());
    }).catch(() => {
    });
  };
}
