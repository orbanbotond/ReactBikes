import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectUser, selectModels } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
import { fetchTheModels } from './action-creators';
import { BikesAxios as Axios, Routes } from '@routes/routes';
import Edit from './edit.component';
import { NavLink } from 'react-router-dom';
import { reduxForm, SubmissionError } from 'redux-form';

class EditContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      user: null,
    };
  }

  componentWillMount() {
    if(!this.state.user){
      const currentUser = this.props.user;
      const id = this.props.match.params.id;

      const query = `
      {
        users(id: "${id}"){
          nodes{
            id,
            email,
            admin
          }
        }
      }
      `

      Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((_responseObj) => {
        this.setState({
          user: _responseObj.data.data.users.nodes[0],
        });
      }).catch((_error) => {
      });
    }
  }

  apiUrl(){
    const id = this.props.match.params.id;
    return Routes.Restfull.member_route('user', id);
  }

  handleSubmit = data => {
    return Axios(this.props.user).put(this.apiUrl(), data).then((responseObj) => {
      this.handleSuccess(responseObj);
    }).catch((error) => {
      this.handleError(error);
    });
  }

  handleError(error) {
    throw new SubmissionError({
      ...error.response.data.details,
      _error: 'Failed!',
    });
  }

  handleSuccess(response) {
    console.debug('Saved Successfull');
  }

  render(){
    var ReduxUserForm = reduxForm({
      form: 'user',
    })(Edit);

    ReduxUserForm = connect( _state => ({
        initialValues: this.state.user
      })
    )(ReduxUserForm)

    const propsToWaitFor = [ 'model', 'user'];
    const LoadWrappedList = LoadSpinnerHOC(propsToWaitFor, ReduxUserForm);

    return(
      <div>
        <LoadWrappedList submitForm={this.handleSubmit}
                         model={this.state.user}
                         {...this.props} />
        <NavLink to={Routes.Browser.Restfull.collection_route('user')}>Back To List</NavLink>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  user: selectUser(state),
});

export default connect(mapStateToProps, {})(EditContainer);
