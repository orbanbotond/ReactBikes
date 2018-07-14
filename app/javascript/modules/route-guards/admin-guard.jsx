import React, { Component } from 'react';
import { selectUser, selectAuthenticated } from '@modules/selectors'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { Routes } from '@routes/routes';

const GuardHOC = (WrappedComponent) => {
  class Guard extends Component {
    componentWillMount() {
      if(!this.isAdmin()){
        this.props.history.push(Routes.Browser.login());
      }
    }

    isAdmin(){
      if(this.unAuthenticated()) return false;

      return this.props.user.admin;
    }

    unAuthenticated(){
      !this.props.authenticated
    }

    render(){
      if(!this.isAdmin()){
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
