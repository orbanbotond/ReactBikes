/*eslint no-unused-vars: "warn"*/
import React from 'react';
import DayPickerInput from 'react-day-picker/DayPickerInput';
import 'react-day-picker/lib/style.css';
import {
  FormGroup,
  Label,
  Col,
  FormFeedback,
} from 'reactstrap';
import { titleCase } from "title-case";

class ControlledFormDateSelect extends React.Component {
  renderError(error) {
    if (typeof error === 'string') return <FormFeedback>{error}</FormFeedback>;

    return error.map(theError => <FormFeedback key={theError}>{theError}</FormFeedback>);
  }

  handleDayChange(day){
    this.props.input.onChange(day);
  }

  render() {
    const {
      input: {
        onChange,
        onBlur,
        name,
        value,
      },
      _options,
      inputSize,
      labelSize,
      label = titleCase(name),
      _placeHolder = label,
      meta: {
        touched,
        error, 
        warning, 
        invalid, 
        valid,
      },
      _toLowerCase,
      valueToOverride,
      disabled,
      className,
    } = this.props;
    const inputValue = valueToOverride || value;

    return (
      <FormGroup row className={className}>
        {label ? <Label for={name} sm={labelSize} >{label}</Label> : ''}
        <Col sm={inputSize} className={[touched && invalid ? 'is-invalid' : '', touched && valid ? 'is-valid' : ''].join(' ')}>
          <DayPickerInput onDayChange={(day) => this.handleDayChange(day)}
                          inputProps={{onBlur: onBlur,
                                      onChange: onChange,
                                      value: inputValue, 
                                      className: "form-control", 
                                      disabled: disabled}}/>
          <span className="validation-icon" />
          {touched &&
            ((error && this.renderError(error)) ||
             (warning && <FormFeedback>{warning}</FormFeedback>))}
        </Col>
      </FormGroup>
    );
  }
}

export default ControlledFormDateSelect;
