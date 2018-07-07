import React, { Component } from 'react';
import { selectUser } from '@modules/selectors'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { Routes } from '@routes/routes';
import { BikesAxios as Axios } from '@routes/routes';
import { login as dispatchLogin } from './action-creators';

class Login extends Component {
  render(){
     Axios()
        .post(Routes.login(),
              {email: "orban@toptal.com", password: "bikepassword123"})
        .then((_responseObj) => {
          this.props.dispatchLogin(_responseObj.data);
        })
        .catch(() => {});

    return (
      <div>
        Login
      </div>
    );
  }
}

const mapDispatchToProps = {
  dispatchLogin,
};

const mapStateToProps = () => ({});
export default connect(mapStateToProps, mapDispatchToProps)(withRouter(Login));
