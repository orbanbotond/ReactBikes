import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { reduxForm, SubmissionError } from 'redux-form';
import { Routes } from '@routes/routes';
import { BikesAxios as Axios } from '@routes/routes';
import SignupForm from './sign-up.component';

class Login extends Component {
  handleSubmit(data) {
    return Axios()
      .post(Routes.signup(), data)
      .then(() => {
        this.props.history.push(Routes.Browser.login());
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
    var ReduxForm = reduxForm({
      form: 'sign-up',
    })(SignupForm);

    return(
      <div>
        <ReduxForm {...this.props}
                    submitForm={this.handleSubmit} />
      </div>
    );
  }
}

const mapStateToProps = () => ({});
export default connect(mapStateToProps, {})(withRouter(Login));
