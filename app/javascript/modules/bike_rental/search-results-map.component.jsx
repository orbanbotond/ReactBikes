import React from 'react';
import { withScriptjs, 
         withGoogleMap, 
         GoogleMap, 
         Marker,
         BicyclingLayer } from "react-google-maps"

const SearchResultsMap = withScriptjs(withGoogleMap((props) =>
  <GoogleMap
      defaultZoom={8}
      defaultCenter={ { lat: props.collection[0].latitude, lng: props.collection[0].longitude }}
  >
    <BicyclingLayer autoUpdate />
    {props.collection.map((coordinate) =>{
      return <Marker key={coordinate.latitude * coordinate.longitude} position={{ lat: coordinate.latitude, lng: coordinate.longitude }} />
    })}
  </GoogleMap>
))

export default SearchResultsMap;
