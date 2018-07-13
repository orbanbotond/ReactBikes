import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';

export default class List extends Component {
  handleDelete = id => {
    this.props.deleteHandler(id);
  }

  render(){
    const rows = this.props.collection.map((model) =>
      <tr key={model.id}>
        <td>{model.id}</td>
        <td>{model.start_date}</td>
        <td>{model.end_date}</td>
        <td>{model.rating}</td>
        <td>
          { model.cancelled ? (
            <span>Cancelled</span>
          ) : (
            <Button outline color="danger" size="sm" onClick={() => this.handleDelete(model.id)}>Cancel</Button>
          )}
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
