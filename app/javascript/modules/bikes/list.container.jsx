import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';
import List from './list.component';
import { selectBikes } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheBikes, deleteTheBike } from './action-creators';
import { Routes } from '@routes/routes';

class ListContainer extends Component {
  componentWillMount() {
    this.props.fetchTheBikes();
  }

  handleDelete(id) {
    this.props.deleteTheBike(id);
  }

  render(){
    const propsToWaitFor = ['collection'];
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
  collection: selectBikes(state),
});

const mapDispatchToProps = {
  fetchTheBikes,
  deleteTheBike,
};

export default connect(mapStateToProps, mapDispatchToProps)(ListContainer);
