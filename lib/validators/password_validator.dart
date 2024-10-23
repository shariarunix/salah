class PasswordValidator {
  PasswordValidator._();

  static String? execute(String password) {
    if(password.isEmpty){
      return 'Please, Enter your password';
    }

    if (password.length <8){
      return 'Enter a password with at least 8 characters';
    }

    return null;
  }
}