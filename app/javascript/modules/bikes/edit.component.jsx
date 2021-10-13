/*eslint no-undef: "warn"*/
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
  models,
}) => {
  const inputSetup = {
    labelSize: 4,
    inputSize: 8,
    validate: [validators.required],
    disabledForm: disableForm,
  };

  const availableColors = gon.available_colors.map(x =>{
    return {id: x, text: x}
  })

  const availableModels = models.map(x =>{
    return x;
  })

  return(
    <div className="container-fluid">
      <Form
        onSubmit={handleSubmit(submitForm)}
        autoComplete="off"
        className="col-lg-6 offset-lg-3">
        <Input
          name="weight"
          label="Weight"
          {...inputSetup} />
        <Select
          {...inputSetup}
          name="color"
          label="Color"
          placeHolder="Select a color..."
          options={availableColors} />
        <Select
          {...inputSetup}
          name="bike_model_id"
          label="Bike Model"
          placeHolder="Select a model..."
          options={availableModels} />
        <Input
          {...inputSetup}
          name="latitude"
          label="Latitude" />
        <Input
          {...inputSetup}
          name="longitude"
          label="Longitude" />
{/*Model*/}
         <Button className="col-lg-12" outline size="sm" color="success" disabled={(dirty && invalid) || (pristine && invalid) || submitting}>Submit</Button>
      </Form>
    </div>
  );
}

export default EditForm;
