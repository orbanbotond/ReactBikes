import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectUser, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheModels } from './action-creators';
import { BikesAxios as Axios, Routes } from '@routes/routes';
import Edit from './edit.component';
import { NavLink } from 'react-router-dom';

class EditContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      bike: null,
    };
  }

  componentWillMount() {
    const id = this.props.match.params.id;

    if(!this.state.bike){
      const currentUser = this.props.user
      const url = Routes.Restfull.member_route('bike', id);

      return Axios(currentUser).get(url).then((_responseObj) => {
        this.setState({
          bike: _responseObj.data,
        });
      }).catch((_error) => {
      });
    }

    if(!this.props.models){
      this.props.fetchTheModels();
    }
  }

  render(){
    const propsToWaitFor = ['model'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, Edit);

    return(
      <div>
        <LoadWrappedList {...this.props} model={this.state.bike} />
        <NavLink to={Routes.Browser.Restfull.collection_route('bike')}>Back To List</NavLink>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  models: selectModels(state),
});

const mapDispatchToProps = {
  fetchTheModels,
};

export default connect(mapStateToProps, mapDispatchToProps)(EditContainer);
