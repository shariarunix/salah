import 'package:validators/validators.dart' as validator;

class EmailValidator {
  EmailValidator._();

  static String? execute(String email) {
    if (email.isEmpty) {
      return 'Please, Enter a email address';
    }
    if (!validator.isEmail(email)) {
      return 'Please, Enter a valid email address';
    }
    return null;
  }
}
