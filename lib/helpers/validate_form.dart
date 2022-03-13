part of 'helpers.dart';

final validatedEmail = MultiValidator([
  RequiredValidator(errorText: 'The email is required'),
  EmailValidator(errorText: 'Enter a valid email')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'Minimum 8 characters')
]);
