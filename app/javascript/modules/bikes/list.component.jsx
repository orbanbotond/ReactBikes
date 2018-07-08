import React, { Component } from 'react';
import { Table } from 'reactstrap';
import PropTypes from 'prop-types';

export default class List extends Component {
  modelName(model_id){
    const model = this.props.models.find(element=>{
      return element.id === model_id;
    });

    return model.text;
  }

  render(){
    const rows = this.props.bikes.map((model) =>
      <tr key={model.id}>
        <th scope="row">{model.id}</th>
        <td>{model.color}</td>
        <td>{model.weight}</td>
        <td>{model.latitude}</td>
        <td>{model.longitude}</td>
        <td>{this.modelName(model.bike_model_id)}</td>
        <td>Edit | Destroy</td>
      </tr>
    );

    return (
      <Table striped hover size="sm">
        <thead>
          <tr>
            <th>#</th>
            <th>Color</th>
            <th>Weight</th>
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
