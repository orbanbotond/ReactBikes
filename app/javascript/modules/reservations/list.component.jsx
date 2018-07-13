import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import { NavLink } from 'react-router-dom';
import { Routes } from '@routes/routes';

export default class List extends Component {
  render(){
    const rows = this.props.collection.map((model) =>
      <tr key={model.id}>
        <th scope="row">{model.id}</th>
        <td>{model.start_date}</td>
        <td>{model.end_date}</td>
        <td>{model.cancelled}</td>
        <td>{model.rating}</td>
        <td>
          <NavLink className="btn btn-outline-success btn-sm col-lg-12" to={Routes.Browser.Restfull.member_route('user', model.user_id)+"/reservations"}>{model.user_id}</NavLink>
        </td>
        <td>
          <NavLink className="btn btn-outline-success btn-sm col-lg-12" to={Routes.Browser.Restfull.member_route('bike', model.bike_id)+"/reservations"}>{model.bike_id}</NavLink>
        </td>
      </tr>
    );

    return (
      <Table striped hover size="sm">
        <thead>
          <tr>
            <th>#</th>
            <th>Start At</th>
            <th>End At</th>
            <th>Cancelled</th>
            <th>Rating</th>
            <th>User</th>
            <th>Bike</th>
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
