import React, { Component } from 'react';
import { connect } from 'react-redux';
import List from './list.component';
import { selectBikes, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheBikes, fetchTheModels, deleteTheBike } from './action-creators';

class ListContainer extends Component {
  componentWillMount() {
    if(!this.props.bikes){
      this.props.fetchTheBikes();
    }
    if(!this.props.models){
      this.props.fetchTheModels();
    }
  }

  handleDelete = id => {
    this.props.deleteTheBike(id);
  }

  render(){
    const propsToWaitFor = ['bikes', 'models'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, List);

    return(
      <LoadWrappedList {...this.props} deleteHandler={this.handleDelete}/>
    );
  }
}

const mapStateToProps = state => ({
  bikes: selectBikes(state),
  models: selectModels(state),
});

const mapDispatchToProps = {
  fetchTheBikes,
  fetchTheModels,
  deleteTheBike,
};

export default connect(mapStateToProps, mapDispatchToProps)(ListContainer);
