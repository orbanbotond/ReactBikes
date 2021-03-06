import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';
import { reduxForm, SubmissionError } from 'redux-form';
import { selectUser, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheModels } from './action-creators';
import { BikesAxios as Axios, Routes } from '@routes/routes';
import Edit from './edit.component';
import PictureUpload from './picture-upload.component';

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

      Axios(currentUser).get(this.apiUrl()).then((_responseObj) => {
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

  handleSubmit = data => {
    return Axios(this.props.user).put(this.apiUrl(), data).then((responseObj) => {
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

    ReduxBikeForm = connect( _state => ({
        initialValues: this.state.bike
      })
    )(ReduxBikeForm)

    const propsToWaitFor = [ 'models', 'model', 'user'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, ReduxBikeForm);
    const props2ToWaitFor = [ 'model'];
    const LoadWrappedPicupload = LoadSpinnerHOC(props2ToWaitFor, PictureUpload);

    return(
      <div class="container-fluid">
        <LoadWrappedList submitForm={this.handleSubmit}
                         model={this.state.bike}
                         {...this.props} />
        <LoadWrappedPicupload model={this.state.bike}/>
        <div className="text-center">
          <NavLink to={Routes.Browser.Restfull.collection_route('bike')}>Back To List</NavLink>
        </div>
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

export default connect(mapStateToProps, mapDispatchToProps)(EditContainer);
