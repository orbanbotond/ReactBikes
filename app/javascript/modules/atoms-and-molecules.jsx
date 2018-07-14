import React from 'react';
import BikeList from './bikes/list.component';
import UserList from './users/list.component';
import ReservationList from './reservations/list.component';
import { PastReservations, FutureReservations } from '@modules/bike_rental';
import { ControlledFormInput, 
         ControlledFormSelect} from '@common/forms';

const reservationProps = {
  collection: [{ 
            id: 1, 
            start_date: "Yesterday", 
            end_date: "Today", 
            cancelled: true,
            rating: 3,
  },{ 
            id: 2, 
            start_date: "Yesterday", 
            end_date: "Today", 
            cancelled: false,
            rating: 5,
  },{ 
            id: 3, 
            start_date: "Yesterday", 
            end_date: "Today", 
            cancelled: false,
            rating: null,
  }
]};

const userProps = {
  collection: [{ 
            id: 1, 
            email: "abracadabra@email.com", 
            admin: true,
  },{
            id: 2, 
            email: "abracadabra@email.com",
            admin: false,
  }
]};

const bikeProps = {
  collection: [{ 
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
  <div className="container regular-form">
    <h1>Reservation</h1>
    <h2>List</h2>
    <ReservationList {...reservationProps} />
    <h2>Past Reservation</h2>
    <PastReservations {...reservationProps} />
    <h2>Future Reservation</h2>
    <FutureReservations {...reservationProps} />
    <h1>User</h1>
    <h2>List</h2>
    <UserList {...userProps} />
    <h1>Bike</h1>
    <h2>List</h2>
    <BikeList {...bikeProps} />
  	<h2>Edit</h2>
    <h1>Form components</h1>
    <ControlledFormInput label="Hm..." input={{ value: 'defaultValue', name: 'sex' }} iputSize="2" labelSize="2" meta={{ valid: true }} />
    <ControlledFormInput placeHolder="Place whatever Just test" input={{ name: 'Controlled Input 1' }} iputSize="2" labelSize="2" meta={{ touched: true, valid: true }} />
    <ControlledFormInput input={{ name: 'Controlled Input2' }} iputSize="2" labelSize="2" meta={{ touched: true, invalid: true, warning: 'This is addictive' }} disabled />
    <ControlledFormInput input={{ name: 'Controlled Input3' }} iputSize="2" labelSize="2" meta={{ touched: true, invalid: true, error: 'Check the input' }} />
    <ControlledFormInput input={{ name: 'Controlled Input4' }} iputSize="2" labelSize="2" meta={{ touched: true, invalid: true, error: 'There are som Problems!' }} />
    <ControlledFormInput input={{ name: 'Controlled Input5' }} type="password" iputSize="3" labelSize="2" meta={{ touched: true, invalid: true }} />
    <ControlledFormSelect input={{
                                  name: 'select_input_name',
                                  }}
                          options={[{ id: 'one', text: 'One And One' },
                                    { id: 'two', text: 'Two The Another' }]}

                          label="Hm..."
                          iputSize="2" 
                          labelSize="2"
                          placeHolder="Please Select..."
                          meta={{ touched: true, invalid: false }}
                           />
    <ControlledFormSelect input={{
                                  name: 'select_input_name',
                                  value: 'two',
                                  }}
                          label="Hm..."
                          options={[{ id: 'one', text: 'One And One' },
                                    { id: 'two', text: 'Two The Another' }]}
                          iputSize="2" 
                          labelSize="2"
                          placeHolder="Please Select..."
                          meta={{ touched: true, invalid: false }}
                           />
    <ControlledFormSelect input={{
                                  name: 'select_input_name',
                                  value: 'one',
                                  }}
                          options={[{ id: 'one', text: 'One And One' },
                                    { id: 'two', text: 'Two The Another' }]}
                          label="Hm..."
                          iputSize="2" 
                          labelSize="2"
                          disabled
                          placeHolder="Please Select..."
                          meta={{ touched: true, invalid: false }}
                           />
  </div>

export default AtomsAndMolecules;
