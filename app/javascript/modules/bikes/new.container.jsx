import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectUser, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheModels } from './action-creators';
import { BikesAxios as Axios, Routes } from '@routes/routes';
import Edit from './edit.component';
import { NavLink } from 'react-router-dom';
import { reduxForm, SubmissionError } from 'redux-form';

class NewContainer extends Component {

  componentWillMount() {
    if(!this.props.models){
      this.props.fetchTheModels();
    }
  }

  apiUrl = () => {
    return Routes.Restfull.collection_route('bike');
  }

  handleSubmit = data => {
    return Axios(this.props.user).post(this.apiUrl(), data).then((responseObj) => {
      this.handleSuccess(responseObj);
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

  handleSuccess(response) {
    console.debug('Saved Successfull');
  }

  render(){
    var ReduxBikeForm = reduxForm({
      form: 'bike',
    })(Edit);

    const propsToWaitFor = [ 'models', 'user'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, ReduxBikeForm);

    return(
      <div>
        <LoadWrappedList submitForm={this.handleSubmit}
                         {...this.props} />
        <NavLink to={Routes.Browser.Restfull.collection_route('bike')}>Back To List</NavLink>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  models: selectModels(state),
  user: selectUser(state),
});

const mapDispatchToProps = {
  fetchTheModels,
};

export default connect(mapStateToProps, mapDispatchToProps)(NewContainer);
