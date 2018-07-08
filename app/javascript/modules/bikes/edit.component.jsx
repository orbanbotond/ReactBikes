import React, { Component } from 'react';

export default class Edit extends Component {
  render(){
    return(
      <div>
        Editing:
        ID:{this.props.model.id}
        weight:{this.props.model.weight}

      </div>
    );
  }
}
