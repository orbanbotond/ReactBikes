import React from 'react';
import { Field } from 'redux-form';
import ControlledFormInput from './controlled-form-input';

import './forms.sass';

const ReduxFormInput = props =>
  <Field {...props} component={ControlledFormInput} />;

export default ReduxFormInput;
