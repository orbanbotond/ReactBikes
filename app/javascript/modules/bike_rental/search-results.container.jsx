import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { selectForm, selectSearchResults, selectModels, selectUser } from '@modules/selectors'
import SearchResult from './search-results.component.jsx'
import { BikesAxios as Axios, Routes } from '@routes/routes';

class SearchResultsContainer extends Component {
	reserveHandler(id){
    console.debug("Reserve");
    var data = { bike_id: id, 
                start_date: this.props.form.start_date, 
                end_date: this.props.form.end_date };
    Axios(this.props.user).post(Routes.Restfull.collection_route('reservation'), data).then(() => {
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
