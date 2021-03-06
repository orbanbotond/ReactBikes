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
      collection: null,
    };
  }

  componentWillMount() {
    const id = this.props.match.params.id;

    if(!this.state.collection){
      Axios(this.props.user).get(Routes.Restfull.member_route('bike', id) + '/reservations').then((_responseObj) => {
        this.setState({
          collection: _responseObj.data,
        });
      }).catch((_error) => {
      });
    }
  }

  render(){
    const propsToWaitFor = ['collection'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, List);

    return(
      <div className="container">
        <LoadWrappedList {...this.props} collection={this.state.collection}/>
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
