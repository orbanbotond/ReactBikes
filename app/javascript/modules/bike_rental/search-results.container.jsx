import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { selectForm, selectSearchResults, selectModels, selectUser } from '@modules/selectors'
import SearchResult from './search-results.component.jsx'
import { BikesAxios as Axios, Routes } from '@routes/routes';

class SearchResultsContainer extends Component {
  constructor(props) {
    super(props);

    this.reserveHandler = this.reserveHandler.bind(this);
  }

	reserveHandler(id){
    const currentUser = this.props.user;

    const query = `
      mutation CreateReservation($startDate: ISO8601Date!, $endDate: ISO8601Date!, $bikeId: ID!){
        createReservation(input:{ startDate: $startDate,
                                  endDate: $endDate,
                                  bikeId: $bikeId} ){
          reservation {
            id,
          },
          errors,
        }
      }
    `

    const variables = `
      {
        "bikeId": "${id}",
        "startDate": "${this.props.form.start_date}",
        "endDate": "${this.props.form.end_date}"
      }
    `

    Axios(currentUser).post(Routes.Rails.graphql, {query: query, variables: variables}).then((_responseObj) => {
      this.props.history.push(Routes.Browser.Restfull.collection_route("reservation"));
    }).catch((_error) => {
    });
  }

  render(){
    return(
      <SearchResult {...this.props} reserveHandler={this.reserveHandler} />
    );
  }
}

const mapStateToProps = state => ({
  collection: selectSearchResults(state),
  models: selectModels(state),
  user: selectUser(state),
  form: selectForm(state, "searchForm"),
});

export default connect(mapStateToProps, {})(withRouter(SearchResultsContainer));
