import React from 'react';
import { Navbar, Nav, NavItem } from 'reactstrap';
import { Routes } from '@routes/routes';
import { connect } from 'react-redux';
import { NavLink, withRouter } from 'react-router-dom';
import { selectUser, selectAuthenticated } from '@modules/selectors'
import { logout as dispatchLogout } from '@modules/login/action-creators';

class Header extends React.Component {
  constructor(props) {
    super(props);

    this.handleLogout = this.handleLogout.bind(this);
  }

  handleLogout(e) {
    e.preventDefault();
    this.props.dispatchLogout();
    this.props.history.push(Routes.Browser.root());
    console.debug("handleLogout")
  }

  render() {
    if(this.props.authenticated){
      if(this.props.user.admin){
        return (
          <Navbar color="faded" light>
            <Nav tabs>
              <NavItem>
                <NavLink activeClassName="active" className="nav-link" to={Routes.Browser.Restfull.collection_route("user")}>Users</NavLink>
              </NavItem>
              <NavItem>
                <NavLink  activeClassName="active" className="nav-link" to={Routes.Browser.Restfull.collection_route("bike")}>Bikes</NavLink>
              </NavItem>
              <NavItem>
                <NavLink  activeClassName="active" className="nav-link" to={Routes.Browser.atoms_and_molecules()}>Atoms & Molecules</NavLink>
              </NavItem>
            </Nav>

            <Nav tabs>
              <NavItem>
                <a href="#" className="nav-link" onClick={this.handleLogout}>Logout</a>
              </NavItem>
            </Nav>
          </Navbar>
        )
      }else{
        return (
          <Navbar color="light" light>
            <Nav tabs>
              <NavItem>
                <NavLink activeClassName="active" className="nav-link" to={Routes.Browser.search()}>Search</NavLink>
              </NavItem>
              <NavItem>
                <NavLink  activeClassName="active" className="nav-link" to={Routes.Browser.Restfull.collection_route("reservation")}>Reservations</NavLink>
              </NavItem>
            </Nav>
            <Nav tabs>
              <NavItem>
                <a href="#" className="nav-link" onClick={this.handleLogout}>Logout</a>
              </NavItem>
            </Nav>
          </Navbar>
        )
      }
    }else{
      return (
        <Navbar color="faded" light>
          <Nav tabs>
            <NavItem>
              <NavLink activeClassName="active" className="nav-link" to={Routes.Browser.login()}>Login</NavLink>
            </NavItem>
            <NavItem>
              <NavLink activeClassName="active" className="nav-link" to={Routes.Browser.signup()}>SignUp</NavLink>
            </NavItem>
          </Nav>
        </Navbar>
      )
    }
  }
}

const mapStateToProps = state => ({
  user: selectUser(state),
  authenticated: selectAuthenticated(state)
});

export default connect(mapStateToProps, {dispatchLogout}, null, { pure: false })(withRouter(Header))
