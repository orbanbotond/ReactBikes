import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import { NavLink } from 'react-router-dom';
import { Routes } from '@routes/routes';

export default class List extends Component {
  render(){
    const rows = this.props.collection.map((model) =>
      <tr key={model.id}>
        <td>{model.id}</td>
        <td>{model.start_date}</td>
        <td>{model.end_date}</td>
        <td>
          { model.rating ? (
            <span>{model.rating}</span>
          ) : (
            <NavLink className="btn btn-outline-success btn-sm" to={Routes.Browser.Restfull.member_subroute('reservation', model.id, "rate")}>Rate</NavLink>
          )}
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
