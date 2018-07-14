import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import Toggle from 'react-bootstrap-toggle';
import FutureReservation from './future-reservation.component';

export default class List extends Component {
  handleDelete = (state, node, evt) => {
    debugger
    const id = node.getAttribute('data');
    console.debug(id);
    console.debug(state);
    console.debug(node);
    console.debug(evt);
  }

  render(){
    const rows = this.props.collection.map((model) =>
      <FutureReservation model={model} />
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
