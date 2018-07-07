/* eslint-env browser */

import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link,
} from 'react-router-dom';

import {AdminGuard} from '@modules/route-guards'

import SecureRoute from '@modules/secure-route';

import AtomsAndMolecules from '@modules/atoms-and-molecules';
import Bikes from '@modules/bikes';
import Users from '@modules/users';
import Login from '@modules/login';

import { Routes } from './routes';

const App = (props) => {
  return (
    <Router>
      <div>
        <Route path={Routes.Browser.login()}
               component={Login} />
        <Route path={Routes.Browser.Restfull.collection_route("bike")}
               component={AdminGuard(Bikes)} />
        <Route path={Routes.Browser.Restfull.collection_route("user")}
               component={AdminGuard(Users)} />

        <Route path={Routes.Browser.atoms_and_molecules()} component={AtomsAndMolecules} />

        <Link to={Routes.Browser.Restfull.collection_route("bike")}>Bikes</Link>
        <Link to={Routes.Browser.Restfull.collection_route("user")}>Users</Link>
      </div>
    </Router>
  );
};

export default App;


        // <SecureRoute path={Routes.Browser.Restfull.collection_route("bike")}
        //              component={Bikes}
        //              guard={AdminRouteGuard}
        //              redirectToPathWhenFail={Routes.Browser.login()}
        //              />
        // <SecureRoute path={Routes.Browser.Restfull.collection_route("user")} 
        //              component={Users} 
        //              guard={AdminRouteGuard}
        //              redirectToPathWhenFail={Routes.Browser.login()}
        //              />
