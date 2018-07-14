import React, { Component } from 'react';
import { selectUser, selectAuthenticated } from '@modules/selectors'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { Routes } from '@routes/routes';

const GuardHOC = (WrappedComponent) => {
  class Guard extends Component {
    componentWillMount() {
      if(this.isAuthenticated()){
        this.props.history.push(Routes.Browser.root());
      }
    }

    isAuthenticated(){
      return this.props.authenticated;
    }

    render(){
      if(this.isAuthenticated()){
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
