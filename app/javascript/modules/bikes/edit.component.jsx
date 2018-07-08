import React, { Component } from 'react';
import { Form, Button } from 'reactstrap';
import { Input, validators } from '@common/forms';

const EditForm = ({
  model, handleSubmit, submitForm, pristine, submitting, disableForm, invalid, dirty, inputSize,
}) => {
  const inputSetup = {
    labelSize: 4,
    inputSize,
    // validate: [validators.required],
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
          input={{ value: model.weight, name: "Weight" }} />
        <Input
          {...inputSetup}
          input={{ value: model.color, name: "Color" }}
        />
        <Input
          {...inputSetup}
          input={{ value: model.latitude, name: "Latitude" }}
        />
        <Input
          {...inputSetup}
          input={{ value: model.longitude, name: "Longitude" }}
        />
{/*Model*/}
         <Button className="col-lg-12" outline size="sm" color="success" inactive={(dirty && invalid) || (pristine && invalid) || submitting}>Submit</Button>
      </Form>
    </div>
  );
}

export default EditForm;
