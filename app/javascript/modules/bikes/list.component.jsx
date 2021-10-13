import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import { NavLink } from 'react-router-dom';
import Rater from 'react-rater'
import { Routes } from '@routes/routes';
import 'react-rater/lib/react-rater.css';

export default class List extends Component {
  handleDelete(id) {
    this.props.deleteHandler(id);
  }

  render(){
    const rows = this.props.collection.map((bike) =>
      <tr key={bike.id}>
        <th scope="row">{bike.id}</th>
        <td>{bike.color}</td>
        <td>{bike.weight}</td>
        <td>
          {bike.image_url && (
            <img src={bike.image_url} width="50"/>
          )}
        </td>
        <td>
          <Rater total={5}
                 rating={bike.average_rating}
                 interactive={false} />
        </td>
        <td>{bike.latitude}</td>
        <td>{bike.longitude}</td>
        <td>{bike.model.text}</td>
        <td>
          <NavLink className="btn btn-outline-success btn-sm" to={Routes.Browser.Restfull.member_subroute('bike', bike.id, 'reservations')}>Reservations</NavLink>
          <NavLink className="btn btn-outline-success btn-sm" to={Routes.Browser.Restfull.member_route('bike', bike.id)}>Edit</NavLink>
          <Button outline color="danger" size="sm" onClick={() => this.handleDelete(bike.id)}>Delete</Button>
        </td>
      </tr>
    );

    return (
      <Table striped hover size="sm">
        <thead>
          <tr>
            <th>#</th>
            <th>Color</th>
            <th>Weight</th>
            <th>Picture</th>
            <th>Average Rating</th>
            <th>Latitude</th>
            <th>Longitude</th>
            <th>Model</th>
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
