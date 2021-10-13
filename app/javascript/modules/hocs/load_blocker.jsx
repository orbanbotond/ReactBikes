import React, { Component } from 'react';

const LoadBlockerHOC = (propsToBePresent, WrappedComponent) => {
  return class LoadSpinner extends Component {
    areAllNeededPropsPresent(){
      return propsToBePresent.every(x=>{return this.props[x]})
    }

    render(){
      return (
        this.areAllNeededPropsPresent() && <WrappedComponent {...this.props} />
      )
    }
  }
}

export default LoadBlockerHOC;
