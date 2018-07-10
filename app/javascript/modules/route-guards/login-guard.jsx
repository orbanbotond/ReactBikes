import React, { Component } from 'react';
import { selectUser } from '@modules/selectors'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { Routes } from '@routes/routes';

const GuardHOC = (WrappedComponent) => {
  class Guard extends Component {
    componentWillMount() {
      if(this.isAuthenticated(this.props)){
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
      if(this.isAuthenticated(this.props)){
        return <div>Not allowed Sorry!</div>
      }else{
        return <WrappedComponent {...this.props} />
      }
    }
  }

  const mapStateToProps = state => ({
    user: selectUser(state)
  });

  return connect(mapStateToProps, {})(withRouter(Guard))
}

export default GuardHOC;
