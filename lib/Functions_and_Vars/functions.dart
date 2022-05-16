import 'package:email_validator/email_validator.dart';
import 'package:string_validator/string_validator.dart';

// Validator class for emails and passwords and other input
class Validators {
  static String? emailValidator(input) {
    if (!EmailValidator.validate(input)) {
      return 'Invalid Email Address';
    }
    return null;
  }

  static String? passwordValidator(input) {
    if (input == null || input.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  static String? ageValidator(input) {
    if (input == null || input.isEmpty || !isNumeric(input)) {
      return 'Enter valid Age';
    }
    return null;
  }

  static String? otherValidator(input) {
    if (input == null || input.isEmpty) {
      return 'Enter valid input';
    }
    return null;
  }
}
