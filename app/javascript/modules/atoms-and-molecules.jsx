import React from 'react';
import BikeList from './bikes/list.component';

const bikeProps = {
  bikes: [{ 
            id: 1, 
            weight: 1.2, 
            color: 'red',
            bike_model_id: 1,
            latitude: 48.210033, 
            longitude: 16.363449
  },{
            id: 2, 
            weight: 2.2, 
            color: 'red',
            bike_model_id: 2,
            latitude: 49.210033, 
            longitude: 18.363449
  }
  ],
  models: [{
    id: 1,
    text: "Mountain",
  },{
    id: 2,
    text: "Road",
  }
  ]
};

const AtomsAndMolecules = () =>
  <div>
  	<h1>Bike</h1>
  	<h2>List</h2>
  	<BikeList {...bikeProps} />
  </div>

export default AtomsAndMolecules;
