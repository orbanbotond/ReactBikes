import React, { Component } from 'react';
import { selectUser, selectAuthenticated } from '@modules/selectors'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { Routes } from '@routes/routes';

const GuardHOC = (WrappedComponent) => {
  class Guard extends Component {
    componentWillMount() {
      if(!this.authenticated()){
        this.props.history.push(Routes.Browser.login());
      }
      if(this.isAdmin()){
        this.props.history.push(Routes.Browser.root());
      }
    }

    isAdmin(){
      if(!this.authenticated()) return false;

      return this.props.user.admin;
    }

    authenticated(){
      return this.props.authenticated;
    }

    render(){
      if(this.authenticated() && this.isAdmin()){
        return null;
      }else{
        return <WrappedComponent {...this.props} />
      }
    }
  }

  const mapStateToProps = state => ({
    user: selectUser(state),
    authenticated: selectAuthenticated(state)
  });

  return connect(mapStateToProps, {})(withRouter(Guard))
}

export default GuardHOC;
