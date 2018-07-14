import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import { NavLink } from 'react-router-dom';
import { Routes } from '@routes/routes';
import Rater from 'react-rater'
import 'react-rater/lib/react-rater.css';

export default class List extends Component {
  render(){
    const rows = this.props.collection.map((model) =>
      <tr key={model.id}>
        <td>{model.id}</td>
        <td>{model.start_date}</td>
        <td>{model.end_date}</td>
        <td>
          <Rater total={5} rating={model.rating} interactive={!model.rating} />
        </td>
        <td>
          { model.cancelled && <span>Cancelled</span> }
        </td>
      </tr>
    );

    return (
      <Table striped hover size="sm">
        <thead>
          <tr>
            <th>#</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Rating</th>
            <th>Cancelled</th>
          </tr>
        </thead>
        <tbody>
          {rows}
        </tbody>
      </Table>
    );
  }
}

// List.contextTypes = {
//   router: React.PropTypes.object.isRequired
// };

List.propTypes = {
  collection: PropTypes.array.isRequired,
}
