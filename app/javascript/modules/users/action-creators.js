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

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((responseObj) => {
      const users = responseObj.data.data.users.nodes;
      dispatch(fetchUsersSuccess(users));
    }).catch((error) => {
      dispatch(fetchUsersError(error));
    });
  };
}

export function deleteTheUser(id) {
  return function (dispatch, getState) {
    const currentUser = getState().session.user;

    const query = `
      mutation DeleteUser($userId: ID!){
        deleteUser(input: {userId: $userId}){
          errors,
        }
      }
    `
    const variables = `
      {
        "userId": "${id}"
      }
    `

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query, variables: variables}).then((_response) => {
      dispatch(fetchTheUsers());
    }).catch((_error) => {
    });
  };
}
