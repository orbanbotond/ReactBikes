import React from 'react';
import { Form, Button } from 'reactstrap';
import { Select, Input, validators } from '@common/forms';

const EditForm = ({
  _model, 
  handleSubmit, 
  submitForm, 
  pristine, 
  submitting, 
  disableForm, 
  invalid, 
  dirty, 
  _inputSize,
}) => {
  const inputSetup = {
    labelSize: 4,
    _inputSize: 8,
    validate: [validators.required],
    disabledForm: disableForm,
  };


  const availableValues = [{id: true, text: "True"}, 
                           {id: false, text: "False"}];

  return(
    <div className="container-fluid">
      <Form
        onSubmit={handleSubmit(submitForm)}
        autoComplete="off"
        className="col-lg-6 offset-lg-3">
        <Input
          {...inputSetup}
          validate={[validators.required, validators.email]}
          name="email"
          label="Email"
        />
        <Select
          {...inputSetup}
          name="admin"
          label="Admin"
          placeHolder="Select a value..."
          value={false}
          options={availableValues} />
        <Input
          {...inputSetup}
          name="password"
          type="password"
          label="Password" />
{/*Model*/}
         <Button className="col-lg-12" outline size="sm" color="success" disabled={(dirty && invalid) || (pristine && invalid) || submitting}>Submit</Button>
      </Form>
    </div>
  );
}

export default EditForm;
