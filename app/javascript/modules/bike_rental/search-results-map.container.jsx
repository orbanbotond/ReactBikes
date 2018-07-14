import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectSearchResults } from '@modules/selectors'
import SearchResultsMap from './search-results-map.component.jsx'
import { LoadSpinnerHOC } from '@modules/hocs'

class SearchResultsMapContainer extends Component {
  render(){
    const propsToWaitFor = [ 'collection' ];
    const LoadWrappedForm = LoadSpinnerHOC(propsToWaitFor, SearchResultsMap);

    return(
      <LoadWrappedForm {...this.props} 
        googleMapURL="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4R6AN7SmujjPUIGKdyao2Kqitzr1kiRg&v=3.exp&libraries=geometry,drawing,places"
        loadingElement={<div style={{ height: `100%` }} />}
        containerElement={<div style={{ height: `400px` }} />}
        mapElement={<div style={{ height: `100%` }} />}
        defaultZoom={8}
        defaultCenter={{ lat: -34.397, lng: 150.644 }}
      />
    );
  }
}

const mapStateToProps = state => ({
  collection: selectSearchResults(state),
});

export default connect(mapStateToProps, {})(SearchResultsMapContainer);
