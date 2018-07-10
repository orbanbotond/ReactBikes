import React, { Component } from 'react';
import { Form, Button } from 'reactstrap';
import { Select, Input, validators } from '@common/forms';

const LoginForm = ({
  model, 
  handleSubmit, 
  submitForm, 
  pristine, 
  submitting, 
  disableForm, 
  invalid, 
  dirty, 
  inputSize,
}) => {
  const inputSetup = {
    labelSize: 4,
    inputSize: 8,
    validate: [validators.required],
    disabledForm: disableForm,
  };

  return(
    <div className="container-fluid">
      <Form
        onSubmit={handleSubmit(submitForm)}
        autoComplete="off"
        className="col-lg-6 offset-lg-3">
        <Input
          {...inputSetup}
          name="email"
          label="Email"
          validate={[validators.required, validators.email]}
        />
        <Input
          {...inputSetup}
          name="password"
          type="password"
          label="Password" />
         <Button className="col-lg-12" outline size="sm" color="success" disabled={(dirty && invalid) || (pristine && invalid) || submitting}>Submit</Button>
      </Form>
    </div>
  );
}

export default LoginForm;
