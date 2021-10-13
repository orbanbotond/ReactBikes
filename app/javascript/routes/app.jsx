/* eslint-env browser */

import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
} from 'react-router-dom';

import { StandardUserGuard, AdminGuard, LoginGuard } from '@modules/route-guards'

import AtomsAndMolecules from '@modules/atoms-and-molecules';
import {BikeReservations, BikeEdit, BikeList, BikeNew} from '@modules/bikes';
import {UserReservations, UserEdit, UserList, UserNew} from '@modules/users';
import {Reservations, Search} from '@modules/bike_rental';
import Login from '@modules/login';
import SignUp from '@modules/sign-up';
import Header from '@common/header';

import { Routes } from './routes';

const App = (_props) => {
  return (
    <Router>
      <div>
        <Header />
        <Route path={Routes.Browser.login()}
               component={LoginGuard(Login)} />
        <Route path={Routes.Browser.signup()}
               component={LoginGuard(SignUp)} />
        <Route path={Routes.Browser.Restfull.collection_route("bike")}
               component={AdminGuard(BikeList)}
               exact />
        <Switch>
          <Route path={Routes.Browser.Restfull.new_route('bike')}
                 component={AdminGuard(BikeNew)}
                 exact />
          <Route path={`${Routes.Browser.Restfull.member_route('bike', ':id')}`}
                 component={AdminGuard(BikeEdit)}
                 exact />
          <Route path={`${Routes.Browser.Restfull.member_subroute('bike', ':id', 'reservations')}`}
                 component={AdminGuard(BikeReservations)}
                 exact />
        </Switch>
        <Route path={Routes.Browser.Restfull.collection_route("user")}
               component={AdminGuard(UserList)}
               exact />
        <Switch>
          <Route path={Routes.Browser.Restfull.new_route('user')}
                 component={AdminGuard(UserNew)}
                 exact />
          <Route path={`${Routes.Browser.Restfull.member_route('user', ':id')}`}
                 component={AdminGuard(UserEdit)}
                 exact />
          <Route path={`${Routes.Browser.Restfull.member_subroute('user', ':id', 'reservations')}`}
                 component={AdminGuard(UserReservations)}
                 exact />
        </Switch>
        <Route path={Routes.Browser.search()}
               component={StandardUserGuard(Search)}
               exact />
        <Route path={Routes.Browser.Restfull.collection_route("reservation")}
               component={StandardUserGuard(Reservations)}
               exact />
        <Route path={Routes.Browser.atoms_and_molecules()} component={AtomsAndMolecules} />
      </div>
    </Router>
  );
};

export default App;
