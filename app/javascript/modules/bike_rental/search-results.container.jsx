import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectSearchResults, selectModels } from '@modules/selectors'
import SearchResult from './search-results.component.jsx'

class SearchResultsContainer extends Component {
	reserveHandler = (id) => {
    // Axios(this.props.user).put(Routes.Restfull.member_route('reservation', id), { rating: rating }).then((_responseObj) => {
    // }).catch((_error) => {
    // });
  }

  render(){
    return(
      <SearchResult {...this.props} />
    );
  }
}

const mapStateToProps = state => ({
  collection: selectSearchResults(state),
  models: selectModels(state),
});

export default connect(mapStateToProps, {})(SearchResultsContainer);
