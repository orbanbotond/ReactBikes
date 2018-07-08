import React, { Component } from 'react';

const LoadSpinnerHOC = (propsToBePresent, WrappedComponent) => {
  return class LoadSpinner extends Component {
    areAllNeededPropsPresent(){
      console.debug("----------------------");
      console.debug("Needed:");
      console.debug(propsToBePresent);
      console.debug("Current:");
      console.debug(this.props);
      console.debug("----------------------");
      return propsToBePresent.every(x=>{return this.props[x]})
    }

    render(){
      return (
        this.areAllNeededPropsPresent() ? <WrappedComponent {...this.props} />
                                        : <div>Loading...</div>
      )
    }
  }
}

export default LoadSpinnerHOC;
