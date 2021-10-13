import React, { Component } from 'react';
import { connect } from 'react-redux';
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

      const query = `
      {
        bikes(id: "${id}"){
          nodes{
            id,
            reservations{
              id,
              end_date: endDate,
              start_date: startDate,
              rating,
              cancelled,
              bike{ id },
              user{ id }
            }
          }
        }
      }
      `

      Axios(this.props.user).post(Routes.Rails.graphql, {query: query}).then((responseObj) => {
        this.setState({
          collection: responseObj.data.data.bikes.nodes[0].reservations.map(reservation => ({
             ...reservation,
             bike_id: reservation.bike.id,
             user_id: reservation.user.id}))
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
