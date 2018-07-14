import React, { Component } from 'react';
import { connect } from 'react-redux';
import { reduxForm, SubmissionError } from 'redux-form';
import { Form, Button } from 'reactstrap';
import { Select, Input, validators } from '@common/forms';
import SearchForm from './search-form.component';
import { actionCreators } from '@modules/bikes';
import { fetchSearchResultsSuccess } from './action-creators';
import { LoadSpinnerHOC } from '@modules/hocs'
import { selectModels, selectUser } from '@modules/selectors'
import { BikesAxios as Axios, Routes } from '@routes/routes';
import BikeResults from './search-results.container';

class SearchContainer extends Component {
  componentWillMount() {
    if(!this.props.models){
      this.props.fetchTheModels();
    }
  }

  handleSubmit = data => {
    return Axios(this.props.user).get(Routes.Queries.available_bikes(), { params: data }).then((_responseObj) => {
      this.handleSuccess(_responseObj);
    }).catch((_error) => {
      this.handleError(_error);
    });
  }

  handleError(error) {
    throw new SubmissionError({
      ...error.response.data.details,
      _error: 'Failed!',
    });
  }

  handleSuccess(response) {
    this.props.fetchSearchResultsSuccess(response.data);
  }

  render(){
    var ReduxSearchForm = reduxForm({
      form: 'searchForm',
    })(SearchForm);

    const propsToWaitFor = [ 'models' ];
    const LoadWrappedForm = LoadSpinnerHOC(propsToWaitFor, ReduxSearchForm);

    return(
      <div>
        <LoadWrappedForm submitForm={this.handleSubmit}
                         models={this.props.models}
                         {...this.props} />
        <BikeResults />
      </div>
    );
  }
}

const mapStateToProps = state => ({
  models: selectModels(state),
  user: selectUser(state),
});

const mapDispatchToProps = {
  fetchTheModels: actionCreators.fetchTheModels,
  fetchSearchResultsSuccess
};

export default connect(mapStateToProps, mapDispatchToProps)(SearchContainer);
