import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Rater from 'react-rater'
import Toggle from 'react-toggle';

import 'react-rater/lib/react-rater.css';
import "react-toggle/style.css" 

export default class Reservation extends Component {
  constructor(props) {
    super(props);
    this.handleRate = this.handleRate.bind(this);
  }

  handleRate(event) {
    this.props.rateHandler(this.props.model.id, event.rating);
  }

  render(){
    const { model } = this.props;

    return (
      <tr key={model.id}>
        <td>{model.id}</td>
        <td>{model.start_date}</td>
        <td>{model.end_date}</td>
        <td>{model.bike_id}</td>
        <td>
          <Rater total={5}
                rating={model.rating}
                interactive={!model.rating}
                onRate={this.handleRate}/>
        </td>
        <td>
          <Toggle
            checked={model.cancelled}
            disabled={true}
          />
        </td>
      </tr>
    );
  }
}

// List.contextTypes = {
//   router: React.PropTypes.object.isRequired
// };

Reservation.propTypes = {
  model: PropTypes.object.isRequired,
}
