import React from 'react';
import {
  Route,
  Redirect,
} from 'react-router-dom';

const SecureRoute = ({ component: Component, 
                       guard, 
                       redirectToPathWhenFail,
                       ...rest }) => (
  <Route {...rest} render={(props) => {
    const guardResult = new guard().hasAccess();
    
    return (
      guardResult ? <Component {...props} />
                  : <Redirect to={{
                      pathname: redirectToPathWhenFail,
                      state: { from: props.location }
                    }} />
    )}}
  />
)

export default SecureRoute;
