import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import Toggle from 'react-toggle';
import { NavLink } from 'react-router-dom';
import { Routes } from '@routes/routes';

import "react-toggle/style.css" 

export default class List extends Component {
  handleDelete(id){
    this.props.deleteHandler(id);
  }

  render(){
    const rows = this.props.collection.map((model) =>
      <tr key={model.id}>
        <th scope="row">{model.id}</th>
        <td>{model.email}</td>
        <td>
          <Toggle
            checked={model.admin}
            disabled={true}
          />
        </td>
        <td>
          <NavLink className="btn btn-outline-success btn-sm" to={Routes.Browser.Restfull.member_subroute('user', model.id, 'reservations')}>Reservations</NavLink>
          <NavLink className="btn btn-outline-success btn-sm" to={Routes.Browser.Restfull.member_route('user', model.id)}>Edit</NavLink>
          <Button outline color="danger" size="sm" onClick={() => this.handleDelete(model.id)}>Delete</Button>
        </td>
      </tr>
    );

    return (
      <Table striped hover size="sm">
        <thead>
          <tr>
            <th>#</th>
            <th>Email</th>
            <th>Admin</th>
            <th>Actions</th>
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
