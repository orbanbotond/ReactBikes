import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';
import List from '@modules/reservations/list.component';
import { selectUser } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { BikesAxios as Axios, Routes } from '@routes/routes';

class ListContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      reservations: null,
    };
  }

  componentWillMount() {
    const id = this.props.match.params.id;

    if(!this.state.reservations){
      Axios(this.props.user).get(Routes.Restfull.member_route('user', id) + '/reservations').then((_responseObj) => {
        this.setState({
          reservations: _responseObj.data,
        });
      }).catch((_error) => {
      });
    }
  }

  render(){
    const propsToWaitFor = ['reservations'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, List);

    return(
      <div className="container">
        <LoadWrappedList {...this.props} reservations={this.state.reservations}/>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  user: selectUser(state),
});

const mapDispatchToProps = {
};

export default connect(mapStateToProps, mapDispatchToProps)(ListContainer);
