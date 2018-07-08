import React, { Component } from 'react';
import { connect } from 'react-redux';
import List from './list.component';
import { selectBikes, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheBikes, fetchTheModels } from './action-creators';

class ListContainer extends Component {
  componentWillMount() {
    if(!this.props.bikes){
      this.props.fetchTheBikes();
    }
    if(!this.props.models){
      this.props.fetchTheModels();
    }
  }

  render(){
    const propsToWaitFor = ['bikes', 'models'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, List);

    return(
      <LoadWrappedList {...this.props} />
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
};

export default connect(mapStateToProps, mapDispatchToProps)(ListContainer);
