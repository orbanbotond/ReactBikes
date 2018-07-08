import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import { NavLink } from 'react-router-dom';
import { Routes } from '@routes/routes';

export default class List extends Component {
  modelName(model_id){
    const model = this.props.models.find(element=>{
      return element.id === model_id;
    });

    return model.text;
  }

  handleDelete = id => {
    this.props.deleteHandler(id);
  }

  render(){
    const rows = this.props.bikes.map((model) =>
      <tr key={model.id}>
        <th scope="row">{model.id}</th>
        <td>{model.color}</td>
        <td>{model.weight}</td>
        <td>{model.average_rating}</td>
        <td>{model.latitude}</td>
        <td>{model.longitude}</td>
        <td>{this.modelName(model.bike_model_id)}</td>
        <td>
          <NavLink className="btn btn-outline-success btn-sm" to={Routes.Browser.Restfull.edit_route('bike', model.id)+ "/reservations"}>Reservations</NavLink>
          <NavLink className="btn btn-outline-success btn-sm" to={Routes.Browser.Restfull.edit_route('bike', model.id)}>Edit</NavLink>
          <Button outline color="danger" size="sm" onClick={() => this.handleDelete(model.id)}>Delete</Button>
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
  bikes: PropTypes.array.isRequired,
  models: PropTypes.array.isRequired,
}
