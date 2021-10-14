import React, { Component } from 'react';
import { connect } from 'react-redux';
import { selectUser } from '@modules/selectors'
import { LoadSpinnerHOC } from '@modules/hocs'
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

    this.handleSubmit = this.handleSubmit.bind(this);
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

      Axios(currentUser).post(Routes.Rails.graphql, {query: query}).then((responseObj) => {
        this.setState({
          user: responseObj.data.data.users.nodes[0],
        });
      }).catch((_error) => {
      });
    }
  }

  handleSubmit(data) {
    const id = this.props.match.params.id;
    const currentUser = this.props.user;

    const query = `
      mutation UpdateUsers($password: String, $admin: Boolean, $email: String, $userId: ID!){
        updateUser(input: {password: $password,
                           admin: $admin,
                           email: $email,
                           userId: $userId}){
          user {
            id,
          },
          errors,
        }
      }
    `
    const variables = `
      {
        "userId": "${id}",
        "admin": ${data.admin},
        "email": "${data.email}",
        "password": "${data.password}"
      }
    `

    return Axios(currentUser).post(Routes.Rails.graphql, {query: query, variables: variables}).then((responseObj) => {
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

  handleSuccess(_response) {
    console.debug('Saved Successfull');
    this.props.history.push(Routes.Browser.Restfull.collection_route('user'));
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
