import React from 'react';
import {
  FormGroup,
  Label,
  Col,
  FormFeedback,
} from 'reactstrap';

const titleCase = require('title-case');

const ControlledFormSelect = ({
  input: { onChange, 
           onBlur,
           name, 
           value,
           options,
  },
  inputSize,
  labelSize,
  label = titleCase(name),
  placeHolder = label,
  meta: {
    touched,
    error, 
    warning, 
    invalid, 
    valid,
  },
  toLowerCase,
  valueToOverride,
  disabled,
  className,
}) => {
  const inputValue = valueToOverride || value;

  var optionsMarkup = options.map(x => {
    return <option value={x.id}>{x.text}</option>
  });
  debugger

  return (
    <FormGroup row className={className}>
      {label ? <Label for={name} sm={labelSize} >{label}</Label> : ''}
      <Col sm={inputSize} className={[touched && invalid ? 'is-invalid' : '', touched && valid ? 'is-valid' : ''].join(' ')}>
        <select name={name}
                id={name}
                value={toLowerCase ? inputValue.toLowerCase() : inputValue}
                onBlur={onBlur}
                disabled={disabled}
                onBlur={onBlur}
                className="form-control"
                onChange={onChange}>
          { placeHolder &&
            <option value="" disabled selected>{placeHolder}</option>
          }
          {optionsMarkup}
        </select>
        <span className="validation-icon" />
        {touched &&
          ((error && this.renderError(error)) ||
           (warning && <FormFeedback>{warning}</FormFeedback>))}
      </Col>
    </FormGroup>
  );
};

export default ControlledFormSelect;
