/* eslint-env browser */

import axios from 'axios';
import createHistory from 'history/createBrowserHistory'; // eslint-disable-line

createHistory();

export const Routes = {};

export const BikesAxios = (currentUser = null) => {
  let header = {};

  if (currentUser) {
    header = { ...header, 'X-Auth-Token': currentUser.session_token };
  }

  const axiosInstance = axios.create({
    timeout: 10000,
    headers: header,
  });

  return axiosInstance;
};

/* API URLS */

Routes.Rails= {};
Routes.Restfull = {};
Routes.Rails.graphql = "/graphql"
Routes.Rails.member_route = (entity_name, id) => `/${entity_name}s/${id}.json`;
Routes.Restfull.collection_route = (entity_name) => `/api/${entity_name}s.json`;
Routes.Restfull.member_route = (entity_name, id) => `/api/${entity_name}s/${id}`;
Routes.Restfull.member_subroute = (entity_name, id, subroute) => `${Routes.Restfull.member_route(entity_name, id)}/${subroute}`;

Routes.Queries = {};
Routes.Queries.available_bikes = () => '/api/queries/available_bikes';

Routes.ping = () => '/api/ping';
Routes.login = () => '/api/login';
Routes.signup = () => '/api/signup';

/* Browser URLS */
Routes.Browser = {};
Routes.Browser.Restfull = {};
Routes.Browser.Restfull.collection_route =(entity_name) => `/${entity_name}s`
Routes.Browser.Restfull.new_route =(entity_name) => `/${entity_name}s/new`
Routes.Browser.Restfull.member_route =(entity_name, id) => `/${entity_name}s/${id}`
Routes.Browser.Restfull.member_subroute =(entity_name, id, subroute) => `${Routes.Browser.Restfull.member_route(entity_name, id)}/${subroute}`
Routes.Browser.search = () => `/search`
Routes.Browser.root =() => `/`
Routes.Browser.login =() => `/login`
Routes.Browser.signup =() => `/signup`
Routes.Browser.atoms_and_molecules =() => `/atoms-and-molecules`
