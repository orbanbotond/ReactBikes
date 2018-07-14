import React, { Component } from 'react';
import { Form, Button } from 'reactstrap';
import { connect } from 'react-redux';
import { selectUser } from '@modules/selectors'
import { BikesAxios as Axios, Routes } from '@routes/routes';
import { Select, Input, validators } from '@common/forms';
import { LoadSpinnerHOC } from '@modules/hocs'
import List from './reservations.component.jsx'

class ReservationsContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      collection: null,
    };
  }

	rateHandler = (id, rating) => {
		console.debug(`Rating Received:${id} ${rating}`);
	}

  componentWillMount() {
    if(!this.state.collection){
      const currentUser = this.props.user

      Axios(currentUser).get(Routes.Restfull.member_subroute('user', currentUser.id, 'reservations')).then((_responseObj) => {
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
        <LoadWrappedList {...this.props} collection={this.state.collection} />
      </div>
    );
  }
}

const mapStateToProps = state => ({
  user: selectUser(state),
});

const mapDispatchToProps = {
};

export default connect(mapStateToProps, mapDispatchToProps)(ReservationsContainer);
