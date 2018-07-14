// This will go into a validation

export const required = value =>
  (value === true || (value && value.trim && value.trim()) ? undefined : 'Required');
export const privacyPolicy = value =>
  (value === true ? undefined : 'Please review and agree to the Privacy Policy before continuing.');
export const maxLength = max => value =>
  (value && value.length > max ? `Must be ${max} characters or less` : undefined);
export const maxLength15 = maxLength(15);
export const minLength = min => value =>
  (value && value.length < min ? `Must be ${min} characters or more` : undefined);
export const minLength2 = minLength(2);
export const minLength8 = minLength(8);
export const minLength9 = minLength(9);
export const number = value =>
  (value && isNaN(Number(value)) ? 'Must be a number' : undefined);
export const minValue = min => value =>
  (value && value < min ? `Must be at least ${min}` : undefined);
export const minValue1 = minValue(1);
export const maxValue = max => value =>
  (value && value > max ? `Must be at most ${max}` : undefined);
export const maxValue5 = maxValue(5);
export const email = value =>
  (value && !/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i.test(value)
    ? 'Invalid email address'
    : undefined);
export const tooOld = value =>
  (value && value > 65 ? 'You might be too old for this' : undefined);
export const aol = value =>
  (value && /.+@aol\.com/.test(value)
    ? 'Really? You still use AOL for your email?'
    : undefined);
export const alphaNumeric = value =>
  (value && /[^a-zA-Z0-9 ]/i.test(value)
    ? 'Only alphanumeric characters'
    : undefined);
export const phoneNumber = value =>
  (value && !/^(0|[1-9][0-9]{9})$/i.test(value)
    ? 'Invalid phone number, must be 10 digits'
    : undefined);
