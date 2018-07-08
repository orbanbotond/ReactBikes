import React, { Component } from 'react';
import { selectUser } from '@modules/selectors'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { reduxForm, SubmissionError } from 'redux-form';
import { Routes } from '@routes/routes';
import { BikesAxios as Axios } from '@routes/routes';
import { login as dispatchLogin } from './action-creators';
import LoginForm from './login.component';

class Login extends Component {
  handleSubmit = data => {
    return Axios()
      .post(Routes.login(), data)
      .then((_responseObj) => {
        this.props.dispatchLogin(_responseObj.data);
      })
      .catch((error) => {
        this.handleError(error);
      });
  }

  handleError(error) {
    throw new SubmissionError({
      ...error.response.data.details,
      _error: 'Failed!',
    });
  }

  render(){
    var ReduxLoginForm = reduxForm({
      form: 'login',
    })(LoginForm);

    return(
      <div>
        <ReduxLoginForm {...this.props}
                        submitForm={this.handleSubmit} />
      </div>
    );
  }
}

const mapDispatchToProps = {
  dispatchLogin,
};

const mapStateToProps = () => ({});
export default connect(mapStateToProps, mapDispatchToProps)(withRouter(Login));
