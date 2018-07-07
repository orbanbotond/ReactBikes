/* eslint-env browser */

import React from 'react';
import {
  BrowserRouter as Router,
  Route,
} from 'react-router-dom';

import AtomsAndMolecules from '@modules/atoms-and-molecules';
import Bikes from '@modules/bikes';
import Users from '@modules/users';

import { Routes } from './routes';

const App = (props) => {
  return (
    <Router>
      <div>
        <Route path={Routes.Browser.Restfull.collection_route("bike")} component={Bikes} />
        <Route path={Routes.Browser.Restfull.collection_route("user")} component={Users} />
        <Route path={Routes.Browser.atoms_and_molecules()} component={AtomsAndMolecules} />
      </div>
    </Router>
  );
};

export default App;
