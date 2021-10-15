import React, { Component } from 'react';
import { connect } from 'react-redux';
import { reduxForm, SubmissionError } from 'redux-form';
import SearchForm from './search-form.component';
import { actionCreators } from '@modules/bikes';
import { fetchSearchResultsSuccess } from './action-creators';
import { LoadSpinnerHOC } from '@modules/hocs'
import { selectModels, selectUser } from '@modules/selectors'
import { BikesAxios as Axios, Routes } from '@routes/routes';
import BikeResults from './search-results.container';
import MapDisplay from './search-results-map.container';

class SearchContainer extends Component {
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

  handleSubmit(data){
    const currentUser = this.props.user;
    const query = `
      query AvailableBikes{
        availableBikes(startDate: "${data.start_date}", endDate:"${data.end_date}", color: "${data.color}", weight: ${data.weight}, rating: ${data.rating}, bikeModelId: "${data.bike_model_id}"){
          nodes{
            id,
            averageRating,
            latitude,
            longitude,
            weight,
            color,
            model{
              id
            },
            imageUrl
          }
        }
      }    
    `

    Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((responseObj) => {
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
    const bikes = response.data.data.availableBikes.nodes.map(bike => ({
           ...bike,
           bike_model_id: bike.model.id}))

    this.props.fetchSearchResultsSuccess(bikes);
  }

  render(){
    var ReduxSearchForm = reduxForm({
      form: 'searchForm',
    })(SearchForm);

    ReduxSearchForm = connect( _state => ({
        initialValues: {start_date: "2018-07-24", end_date: Date.now()}
      })
    )(ReduxSearchForm)

    const propsToWaitFor = [ 'models' ];
    const LoadWrappedForm = LoadSpinnerHOC(propsToWaitFor, ReduxSearchForm);
    const LoadWrappedResults = LoadSpinnerHOC(propsToWaitFor, BikeResults);

    return(
      <div>
        <LoadWrappedForm submitForm={this.handleSubmit}
                         models={this.props.models}
                         {...this.props} />
        <LoadWrappedResults models={this.props.models} {...this.props} />
        <MapDisplay />
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
