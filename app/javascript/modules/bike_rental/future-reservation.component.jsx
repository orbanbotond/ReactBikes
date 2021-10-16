import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Toggle from 'react-toggle';
import Rater from 'react-rater'
import 'react-rater/lib/react-rater.css';
import "react-toggle/style.css" 

export default class Reservation extends Component {
  constructor(props) {
    super(props);

    this.state = {
      cancelled: props.model.cancelled,
    };

    this.handleCancel = this.handleCancel.bind(this);
  }

  handleCancel(_state, _node, _evt){
    this.setState({
      cancelled: !this.state.cancelled,
    });

    this.props.cancelHandler(this.props.model.id);
  }

  render(){
    const { model } = this.props;

    return (
      <tr>
        <td>{model.id}</td>
        <td>{model.start_date}</td>
        <td>{model.end_date}</td>
        <td>
          <Rater total={5} 
                 rating={model.rating} 
                 interactive={false} />
        </td>
        <td>
          <Toggle
            checked={this.state.cancelled}
            onChange={this.handleCancel}
            disabled={this.state.cancelled}
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
