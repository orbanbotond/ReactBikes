import React, { Component } from 'react';
import { connect } from 'react-redux';
import List from './list.component';
import { selectBikes, selectModels } from '@modules/selectors'

class ListContainer extends Component {
  componentWillMount() {

  }

  render(){

    return(
      <div />

    );
  }
}

const mapStateToProps = state => ({
  bikes: selectBikes(state),
  models: selectModels(state),
});

export default connect(mapStateToProps, {})(ListContainer)
