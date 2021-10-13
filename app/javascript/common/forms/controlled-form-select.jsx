import React from 'react';
import {
  FormGroup,
  Label,
  Col,
  FormFeedback,
} from 'reactstrap';

import { titleCase } from "title-case";

class ControlledFormSelect extends React.Component {
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
      options,
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
    } = this.props;
    const inputValue = valueToOverride || value;

    var optionsMarkup = options.map(x => {
      return <option key={x.id} value={x.id}>{x.text}</option>
    });

    return (
      <FormGroup row className={className}>
        {label ? <Label for={name} sm={labelSize} >{label}</Label> : ''}
        <Col sm={inputSize} className={[touched && invalid ? 'is-invalid' : '', touched && valid ? 'is-valid' : ''].join(' ')}>
          <select name={name}
                  id={name}
                  value={toLowerCase ? inputValue.toLowerCase() : inputValue}
                  disabled={disabled}
                  onBlur={onBlur}
                  className="form-control"
                  onChange={onChange}>
            { placeHolder &&
              <option value="" disabled>{placeHolder}</option>
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
  }
}

export default ControlledFormSelect;
