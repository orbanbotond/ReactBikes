import React, { Component } from 'react';
import { withScriptjs, withGoogleMap, GoogleMap, Marker } from "react-google-maps"

// AIzaSyBR2i3ZaehK6msz5Ton9i28DKk3YIlIIpY

const SearchResultsMap = withScriptjs(withGoogleMap((props) =>
  <GoogleMap>
  	{props.collection.map(coordinate =>{
	   <Marker position={{ lat: coordinate.latitude, lng: coordinate.latitude }} />
  	})}
  </GoogleMap>
))

//
// <SearchResultsMap googleMapURL="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4R6AN7SmujjPUIGKdyao2Kqitzr1kiRg&v=3.exp&libraries=geometry,drawing,places" />
//

export default SearchResultsMap;
