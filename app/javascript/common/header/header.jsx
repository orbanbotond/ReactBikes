import React from 'react';
import { Nav, NavItem } from 'reactstrap';
import { Routes } from '@routes/routes';
import { NavLink } from 'react-router-dom';

export default class Header extends React.Component {
  render() {
    return (
      <div>
        <Nav tabs>
          <NavItem>
            <NavLink activeClassName="active" className="nav-link" to={Routes.Browser.Restfull.collection_route("user")}>Users</NavLink>
          </NavItem>
          <NavItem>
            <NavLink  activeClassName="active" className="nav-link" to={Routes.Browser.Restfull.collection_route("bike")}>Bikes</NavLink>
          </NavItem>
        </Nav>
      </div>
    )
  }
}
