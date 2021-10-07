import React, { Component } from 'react';
import FutureList from './future-reservations.component'
import PastList from './past-reservations.component'

export default class ReservationsComponent extends Component {
  constructor(props) {
    super(props);
    this.state = {
      past:   props.collection.filter(model => Date.parse(model.end_date) < Date.now() ),
      future: props.collection.filter(model => Date.parse(model.start_date) >= Date.now() ),
    };
  }


  render(){
    return(
      <div className="container">
        <h3>Past Reservations:</h3>
        <PastList {...this.props} collection={this.state.past} />
        <h3>Future Reservations:</h3>
        <FutureList {...this.props} collection={this.state.future} />
      </div>
    );
  }
}
