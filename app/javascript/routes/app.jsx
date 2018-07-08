/* eslint-env browser */

import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Link,
} from 'react-router-dom';

import { AdminGuard, LoginGuard} from '@modules/route-guards'

import SecureRoute from '@modules/secure-route';

import AtomsAndMolecules from '@modules/atoms-and-molecules';
import {BikeReservations, BikeEdit, BikeList, BikeNew} from '@modules/bikes';
import {UserReservations, UserEdit, UserList, UserNew} from '@modules/users';
import Login from '@modules/login';
import Header from '@common/header';

import { Routes } from './routes';

const App = (props) => {
  return (
    <Router>
      <div>
        <Header />
        <Route path={Routes.Browser.login()}
               component={LoginGuard(Login)} />

        <Route path={Routes.Browser.Restfull.collection_route("bike")}
               component={AdminGuard(BikeList)}
               exact />
        <Switch>
          <Route path={Routes.Browser.Restfull.new_route('bike')}
                 component={AdminGuard(BikeNew)} 
                 exact />
          <Route path={`${Routes.Browser.Restfull.collection_route("bike")}/:id`}
                 component={AdminGuard(BikeEdit)} 
                 exact />
          <Route path={`${Routes.Browser.Restfull.collection_route("bike")}/:id/reservations`}
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
          <Route path={`${Routes.Browser.Restfull.collection_route("user")}/:id`}
                 component={AdminGuard(UserEdit)}
                 exact />
          <Route path={`${Routes.Browser.Restfull.collection_route("user")}/:id/reservations`}
                 component={AdminGuard(UserReservations)}
                 exact />
        </Switch>

        <Route path={Routes.Browser.atoms_and_molecules()} component={AtomsAndMolecules} />
      </div>
    </Router>
  );
};

export default App;
