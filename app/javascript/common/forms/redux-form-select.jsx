import React from 'react';
import { Field } from 'redux-form';
import ControlledFormSelect from './controlled-form-select';

const ReduxFormSelect = props =>
  <Field {...props} component={ControlledFormSelect} />;

export default ReduxFormSelect;
