import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectSearchResults } from '@modules/selectors'
import SearchResultsMap from './search-results-map.component.jsx'
import { LoadBlockerHOC } from '@modules/hocs'

class SearchResultsMapContainer extends Component {
  render(){
    const propsToWaitFor = [ 'collection' ];
    const LoadWrappedForm = LoadBlockerHOC(propsToWaitFor, SearchResultsMap);

    return(
      <LoadWrappedForm {...this.props} 
        googleMapURL="https://maps.googleapis.com/maps/api/js?key=AIzaSyBR2i3ZaehK6msz5Ton9i28DKk3YIlIIpY"
        loadingElement={<div style={{ height: `100%` }} />}
        containerElement={<div style={{ height: `400px` }} />}
        mapElement={<div style={{ height: `100%` }} />}
      />
    );
  }
}

const mapStateToProps = state => ({
  collection: selectSearchResults(state),
});

export default connect(mapStateToProps, {})(SearchResultsMapContainer);
