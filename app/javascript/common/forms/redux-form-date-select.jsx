import React from 'react';
import { Field } from 'redux-form';
import ControlledFormDateSelect from './controlled-form-date-select';

const ReduxFormInput = props =>
  <Field {...props} component={ControlledFormDateSelect} />;

export default ReduxFormInput;
