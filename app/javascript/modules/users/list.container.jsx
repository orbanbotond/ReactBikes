import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';
import List from './list.component';
import { selectUsers } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheUsers, deleteTheUser } from './action-creators';
import { Routes } from '@routes/routes';

class ListContainer extends Component {
  componentWillMount() {
    this.props.fetchTheUsers();
  }

  handleDelete(id) {
    this.deleteTheUser(id);
  }

  render(){
    const propsToWaitFor = ['collection'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, List);

    return(
      <div className="container">
        <LoadWrappedList {...this.props} deleteHandler={this.handleDelete}/>

        <NavLink className="btn btn-outline-success btn-sm col-lg-12" to={Routes.Browser.Restfull.new_route('user')}>Create New User</NavLink>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  collection: selectUsers(state),
});

const mapDispatchToProps = {
  fetchTheUsers,
  deleteTheUser,
};

export default connect(mapStateToProps, mapDispatchToProps)(ListContainer);
