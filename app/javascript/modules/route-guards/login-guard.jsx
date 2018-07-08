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
      if(this.isAuthenticated(this.props)){
        this.routeToFailed();
      }
    }

    componentWillReceiveProps(newProps) {
      if(this.isAuthenticated(newProps)){
        this.routeToFailed();
      }
    }

    isAuthenticated(prop){
      return prop.user.email;
    }

    routeToFailed(){
      this.props.history.push(Routes.Browser.Restfull.collection_route("user"));
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
