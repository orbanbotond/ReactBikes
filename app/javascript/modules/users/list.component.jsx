import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import { NavLink } from 'react-router-dom';
import { Routes } from '@routes/routes';

export default class List extends Component {
  handleDelete = id => {
    this.props.deleteHandler(id);
  }

  render(){
    const rows = this.props.users.map((model) =>
      <tr key={model.id}>
        <th scope="row">{model.id}</th>
        <td>{model.email}</td>
        <td>{model.admin}</td>
        <td>
          <NavLink className="btn btn-outline-success btn-sm" to={Routes.Browser.Restfull.edit_route('user', model.id)}>Edit</NavLink>
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
  models: PropTypes.array.isRequired,
}
