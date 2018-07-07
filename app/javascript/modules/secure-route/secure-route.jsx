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
    debugger
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


// const SecureRoute = ({ component: Component, 
//                        guard, 
//                        redirectToPathWhenFail,
//                        ...rest }) => {
//   <Route {...rest} render={(props) => {
//         debugger
//         result = guard() ? <Component {...props} />
//                          : <Redirect to={redirectToPathWhenFail} />
//         return result;
//     }}
//   />
// }

export default SecureRoute;
