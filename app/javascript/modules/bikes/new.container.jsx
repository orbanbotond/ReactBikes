import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectUser, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheModels } from './action-creators';
import { BikesAxios as Axios, Routes } from '@routes/routes';
import Edit from './edit.component';
import { NavLink, withRouter } from 'react-router-dom';
import { reduxForm, SubmissionError } from 'redux-form';

class NewContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      bike: null,
    };

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentWillMount() {
    if(!this.props.models){
      this.props.fetchTheModels();
    }
  }

  apiUrl() {
    return Routes.Restfull.collection_route('bike');
  }

  handleSubmit(data) {
      const currentUser = this.props.user;

      const variables = `
        {
          "color": "${data.color}",
          "weight": ${data.weight},
          "bikeModelId": "QmlrZU1vZGVsLTE5",
          "latitude": ${data.latitude},
          "longitude": ${data.longitude}
        }
      `

      const query = `
        mutation CreateBikes($color: BikeColorsEnum!, $weight: Float!, $latitude: Float!, $longitude: Float!, $bikeModelId: ID!){
          createBike(input: {color: $color, 
                             weight: $weight,
                             latitude: $latitude,
                             longitude: $longitude,
                             bikeModelId: $bikeModelId}){
            bike {
              id
            }
          }
        }
      `

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query, variables: variables}).then((responseObj) => {
      this.handleSuccess(responseObj);
      this.props.history.push(Routes.Browser.Restfull.collection_route('bike'));
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

export default connect(mapStateToProps, mapDispatchToProps)(withRouter(NewContainer));
