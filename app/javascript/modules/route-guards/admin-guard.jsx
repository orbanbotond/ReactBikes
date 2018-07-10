import React, { Component } from 'react';
import { selectUser } from '@modules/selectors'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { Routes } from '@routes/routes';

const GuardHOC = (WrappedComponent) => {
  class Guard extends Component {
    componentWillMount() {
      if(!this.isAdmin(this.props)){
        this.routeToFailed();
      }
    }

    isAdmin(prop){
      if(this.unAuthenticated(prop)) return false;

      return prop.user.admin;
    }

    unAuthenticated(prop){
      !prop.user
    }

    routeToFailed(){
      this.props.history.push(Routes.Browser.login());
    }

    render(){
      if(!this.isAdmin(this.props)){
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
