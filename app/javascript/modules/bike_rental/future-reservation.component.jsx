import React, { Component } from 'react';
import { Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import Toggle from 'react-bootstrap-toggle';

export default class Reservation extends Component {
  constructor(props) {
    super(props);

    this.state = {
      cancelled: props.model.cancelled,
    };
  }

  handleDelete = (state, node, evt) => {
    const id = node.getAttribute('data');
    console.debug(id);

    this.setState({
      cancelled: !this.state.cancelled,
    });
  }

  render(){
    const { model } = this.props;

    return (
      <tr key={model.id}>
        <td>{model.id}</td>
        <td>{model.start_date}</td>
        <td>{model.end_date}</td>
        <td>{model.rating}</td>
        <td>
          <Toggle
            data={model.id}
            onClick={this.handleDelete}
            on="Cancelled"
            off="Active"
            size="xs"
            offstyle="danger"
            active={this.state.cancelled}
            disabled={!!model.cancelled}
          />
        </td>
      </tr>
    );
  }
}

// List.contextTypes = {
//   router: React.PropTypes.object.isRequired
// };

Reservation.propTypes = {
  model: PropTypes.object.isRequired,
}
