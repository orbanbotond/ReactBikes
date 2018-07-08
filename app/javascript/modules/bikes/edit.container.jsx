import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectUser, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheModels } from './action-creators';
import { BikesAxios as Axios, Routes } from '@routes/routes';
import Edit from './edit.component';
import { NavLink } from 'react-router-dom';
import { reduxForm, SubmissionError } from 'redux-form';

class EditContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      bike: null,
    };
  }

  componentWillMount() {
    if(!this.state.bike){
      const currentUser = this.props.user

      return Axios(currentUser).get(this.apiUrl()).then((_responseObj) => {
        this.setState({
          bike: _responseObj.data,
        });
      }).catch((_error) => {
      });
    }

    if(!this.props.models){
      this.props.fetchTheModels();
    }
  }

  apiUrl(){
    const id = this.props.match.params.id;
    return Routes.Restfull.member_route('bike', id);
  }

  handleSubmit(data){
    debugger
    return Axios().put(this.apiUrl(), data).then((responseObj) => {
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
    const ReduxBikeForm = reduxForm({
      form: 'bike',
    })(Edit);

    const propsToWaitFor = ['model'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, ReduxBikeForm);

    return(
      <div>
        <LoadWrappedList inputSize="8" submitForm={this.handleSubmit} {...this.props} model={this.state.bike} />
        <NavLink to={Routes.Browser.Restfull.collection_route('bike')}>Back To List</NavLink>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  models: selectModels(state),
});

const mapDispatchToProps = {
  fetchTheModels,
};

export default connect(mapStateToProps, mapDispatchToProps)(EditContainer);
