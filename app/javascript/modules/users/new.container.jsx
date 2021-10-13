import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectUser } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { BikesAxios as Axios, Routes } from '@routes/routes';
import Edit from './edit.component';
import { NavLink, withRouter } from 'react-router-dom';
import { reduxForm, SubmissionError } from 'redux-form';

class NewContainer extends Component {

  apiUrl() {
    return Routes.Restfull.collection_route('user');
  }

  handleSubmit(data) {
    return Axios(this.props.user).post(this.apiUrl(), data).then((responseObj) => {
      this.handleSuccess(responseObj);
      this.props.history.push(Routes.Browser.Restfull.collection_route('user'));
    }).catch((error) => {
      this.handleError(error);
    });
  }

  handleError(error) {
    throw new SubmissionError({
      ...error.response.data.details,
      _error: 'Failed!',
    });
  }

  handleSuccess(_response) {
    console.debug('Saved Successfull');
  }

  render(){
    const ReduxUserForm = reduxForm({
      form: 'user',
    })(Edit);

    const propsToWaitFor = ['user'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, ReduxUserForm);

    return(
      <div>
        <LoadWrappedList submitForm={this.handleSubmit}
                         {...this.props} />
        <NavLink to={Routes.Browser.Restfull.collection_route('user')}>Back To List</NavLink>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  user: selectUser(state),
});

export default connect(mapStateToProps, {})(withRouter(NewContainer));
