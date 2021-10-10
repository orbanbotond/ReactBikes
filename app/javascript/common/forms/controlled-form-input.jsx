import React from 'react';
import {
  FormGroup,
  Label,
  Col,
  FormFeedback,
} from 'reactstrap';

import { titleCase } from "title-case";

class ControlledFormInput extends React.Component {
  renderError(error) {
    if (typeof error === 'string') return <FormFeedback>{error}</FormFeedback>;

    return error.map(theError => <FormFeedback key={theError}>{theError}</FormFeedback>);
  }

  render() {
    const {
      input: {
        onChange,
        onBlur,
        name,
        value,
      },
      inputSize,
      labelSize,
      label = titleCase(name),
      type = 'text',
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
    } = this.props;
    const inputValue = valueToOverride || value;

    return (
      <FormGroup row className={className}>
        {label ? <Label for={name} sm={labelSize} >{label}</Label> : ''}
        <Col sm={inputSize} className={[touched && invalid ? 'is-invalid' : '', touched && valid ? 'is-valid' : ''].join(' ')}>
          <input
            name={name}
            type={type}
            disabled={disabled}
            id={name}
            placeholder={placeHolder}
            className="form-control"
            onChange={onChange}
            onBlur={onBlur}
            value={toLowerCase ? inputValue.toLowerCase() : inputValue}
          />
          <span className="validation-icon" />
          {touched &&
            ((error && this.renderError(error)) ||
             (warning && <FormFeedback>{warning}</FormFeedback>))}
        </Col>
      </FormGroup>
    );
  }
}

export default ControlledFormInput;
