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

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentWillMount() {
    if(!this.state.bike){
      const currentUser = this.props.user
      const id = this.props.match.params.id;

      const query = `
      {
        bikes(id: "${id}"){
          nodes{
            id,
            color,
            weight,
            imageUrl,
            averageRating,
            latitude,
            longitude,
            model{
              id,
              text
            }
          }
        }
      }
      `

      Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((responseObj) => {
        this.setState({
          bike: responseObj.data.data.bikes.nodes[0],
        });
      }).catch(() => {
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

  handleSubmit(data) {
    const currentUser = this.props.user;

    const variables = `
      {
        "bikeId": "${data.id}",
        "color": "${data.color}",
        "weight": ${data.weight},
        "bikeModelId": "${data.bike_model_id}",
        "latitude": ${data.latitude},
        "longitude": ${data.longitude}
      }
    `

    const query = `
      mutation UpdateBikes($color: BikeColorsEnum, $weight: Float, $latitude: Float, $longitude: Float, $bikeModelId: ID, $bikeId: ID!){
        updateBike(input: {color: $color, 
                           weight: $weight,
                           bikeModelId: $bikeModelId
                           latitude: $latitude,
                           longitude: $longitude,
                           bikeId: $bikeId}){
          bike {
            id,
          },
          errors,
        }
      }
    `

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query, variables: variables}).then((responseObj) => {
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

  handleSuccess(_response) {
    console.debug('Saved Successfull');
    this.props.history.push(Routes.Browser.Restfull.collection_route('bike'));
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
      <div className="container-fluid">
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
