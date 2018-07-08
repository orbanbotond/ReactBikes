import React, { Component } from 'react';

const LoadSpinnerHOC = (propsToBePresent, WrappedComponent) => {
  return class LoadSpinner extends Component {
    areAllNeededPropsPresent(){
      console.debug("Need to be present:");
      console.debug(propsToBePresent);
      console.debug("Actual values:");
      console.debug(this.props);
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
