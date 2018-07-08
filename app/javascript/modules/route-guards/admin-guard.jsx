import React, { Component } from 'react';
import { selectUser } from '@modules/selectors'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { Routes } from '@routes/routes';

const GuardHOC = (WrappedComponent) => {
  class Guard extends Component {
    componentWillUnmount() {
    }

    componentWillMount() {
      if(!this.isAdmin(this.props)){
        this.routeToFailed();
      }
    }

    componentWillReceiveProps(newProps) {
      if(!this.isAdmin(newProps)){
        this.routeToFailed();
      }
    }

    isAdmin(prop){
      if(!prop.user) return false;

      return prop.user.admin;
    }

    routeToFailed(){
      this.props.history.push(Routes.Browser.login());
    }

   render(){
     return <WrappedComponent {...this.props} />
   }
  }

  const mapStateToProps = state => ({
    user: selectUser(state)
  });

  return connect(mapStateToProps, {})(withRouter(Guard))
}

export default GuardHOC;
