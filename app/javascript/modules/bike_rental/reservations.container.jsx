import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectUser } from '@modules/selectors'
import { BikesAxios as Axios, Routes } from '@routes/routes';
import { LoadSpinnerHOC } from '@modules/hocs'
import List from './reservations.component.jsx'

class ReservationsContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      collection: null,
    };

    this.componentWillMount = this.componentWillMount.bind(this);
    this.rateHandler = this.rateHandler.bind(this);
    this.cancelHandler = this.cancelHandler.bind(this);
  }

  updateGql(){
    return `
      mutation UpdateReservation($cancelled: Boolean, $rating: Int, $reservationId: ID!){
        updateReservation(input:{ cancelled: $cancelled,
                                  rating: $rating,
                                  reservationId: $reservationId} ){
          reservation{
            id,
          },
          errors,
        }
      }
    `
  }

	rateHandler(id, rating){
    const currentUser = this.props.user;

    const query = this.updateGql();

    const variables = `
      {
        "reservationId": "${id}",
        "rating": ${rating}
      }
    `

    Axios(currentUser).post(Routes.Rails.graphql, {query: query, variables: variables}).then((_responseObj) => {
    }).catch((_error) => {
    });
  }

  cancelHandler(id){
    const currentUser = this.props.user;

    const query = this.updateGql();

    const variables = `
      {
        "reservationId": "${id}",
        "cancelled": true
      }
    `

    Axios(currentUser).post(Routes.Rails.graphql, {query: query, variables: variables}).then((_responseObj) => {
    }).catch((_error) => {
    });    
  }

  componentWillMount() {
    if(!this.state.collection){
      const currentUser = this.props.user

      const query = `
      {
        users(id: "${currentUser.gql_id}"){
          nodes{
            id,
            reservations{
              id,
              end_date: endDate,
              start_date: startDate,
              rating,
              cancelled,
              bike{ id }
            }
          }
        }
      }
      `

      Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((responseObj) => {
        this.setState({
          collection: responseObj.data.data.users.nodes[0].reservations.map(reservation => ({
             ...reservation,
             bike_id: reservation.bike.id}))
        });
      }).catch(() => {
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
