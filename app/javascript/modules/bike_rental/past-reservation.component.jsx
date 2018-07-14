import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import Toggle from 'react-bootstrap-toggle';
import Rater from 'react-rater'
import 'react-rater/lib/react-rater.css';

export default class Reservation extends Component {
  constructor(props) {
    super(props);
    this.handleRate = this.handleRate.bind(this);
  }

  handleRate = (event) => {
    this.props.rateHandler(this.props.model.id, event.rating);
  }

  render(){
    const { model } = this.props;

    return (
      <tr key={model.id}>
        <td>{model.id}</td>
        <td>{model.start_date}</td>
        <td>{model.end_date}</td>
        <td>
          <Rater total={5} rating={model.rating} interactive={!model.rating} onRate={this.handleRate}/>
        </td>
        <td>
          { model.cancelled && <span>Cancelled</span> }
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
