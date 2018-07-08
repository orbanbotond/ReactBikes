import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';
import List from './list.component';
import { selectBikes, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheBikes, fetchTheModels, deleteTheBike } from './action-creators';
import { Routes } from '@routes/routes';

class ListContainer extends Component {
  componentWillMount() {
    this.props.fetchTheBikes();
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
      <div className="container">
        <LoadWrappedList {...this.props} deleteHandler={this.handleDelete}/>

        <NavLink className="btn btn-outline-success btn-sm col-lg-12" to={Routes.Browser.Restfull.new_route('bike')}>Create New Bike</NavLink>
      </div>
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
