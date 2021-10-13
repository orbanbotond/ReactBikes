/*eslint no-undef: "warn"*/
import React from 'react';
import { Form, Button } from 'reactstrap';
import { Select, 
          DateSelect, 
          Input, 
          validators } from '@common/forms';

const SearchForm = ({
  models, 
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
    inputSize: 8,
    disabledForm: disableForm,
  };

  const availableColors = [...gon.available_colors, ""].map(x =>{
    return { id: x, text: x }
  });

  const availableModels = [...models, {id: null, text: ""}].map(x =>{
    return x;
  });

  return(
    <div className="container-fluid">
      <Form
        onSubmit={handleSubmit(submitForm)}
        autoComplete="off"
        className="col-lg-6 offset-lg-3">
        <DateSelect
          {...inputSetup}
          validate={[validators.required]}
          name="start_date"
          label="Start Date"
        />
        <DateSelect
          {...inputSetup}
          validate={[validators.required]}
          name="end_date"
          label="End Date"
        />
        <Select
          {...inputSetup}
          name="color"
          label="Prefered Color"
          placeHolder="Select a color..."
          options={availableColors} />
        <Select
          {...inputSetup}
          name="bike_model_id"
          label="Prefered Model"
          placeHolder="Select a model..."
          options={availableModels} />
        <Input
          {...inputSetup}
          validate={[validators.number]}
          name="weight"
          label="Maximum Weight"
        />
        <Input
          {...inputSetup}
          validate={[validators.number, validators.minValue1, validators.maxValue5]}
          name="rating"
          label="Minimum Rating"
        />
         <Button className="col-lg-12" outline size="sm" color="success" disabled={(dirty && invalid) || (pristine && invalid) || submitting}>Search</Button>
      </Form>
    </div>
  );
}

export default SearchForm;
