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
    Axios(this.props.user).put(Routes.Restfull.member_route('reservation', id), { rating: rating }).then((_responseObj) => {
    }).catch((_error) => {
    });
  }

  cancelHandler = (id) => {
    Axios(this.props.user).put(Routes.Restfull.member_route('reservation', id), { cancelled: true }).then((_responseObj) => {
    }).catch((_error) => {
    });    
  }

  componentWillMount() {
    if(!this.state.collection){
      const currentUser = this.props.user

      const query = `
      {
        users(id: "${currentUser.id}"){
          nodes{
            id,
            reservations{
              id,
              end_date: endDate,
              start_date: startDate,
              rating,
              cancelled,
              bike_id: bike{ id }
            }
          }
        }
      }
      `

      Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((_responseObj) => {
        this.setState({
          collection: _responseObj.data.data.users.nodes[0].reservations.map(reservation => ({
             ...reservation,
             bike_id: reservation.bike_id.id}))
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
        <LoadWrappedList {...this.props} 
            collection={this.state.collection} 
            rateHandler={this.rateHandler} 
            cancelHandler={this.cancelHandler} />
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
