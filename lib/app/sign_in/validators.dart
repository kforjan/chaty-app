abstract class StringValidator {
  bool isValid(String string);
  String getErrorMessage(String string);
}

class EmailValidator extends StringValidator {
  bool isValid(String email) {
    if (email == null ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
      return false;
    }
    return true;
  }

  String getErrorMessage(String email) {
    if (email == null) return 'Please enter an e-mail';
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) return 'Please enter a valid e-mail';
    return null;
  }
}

class PasswordValidator extends StringValidator {
  bool isValid(String password) {
    if (password == null ||
        !RegExp(r"^((?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,20})$")
            .hasMatch(password)) {
      return false;
    }
    return true;
  }

  String getErrorMessage(String password) {
    if (password == null) return 'Please enter a password.';
    if (password.length < 8)
      return 'Your password should be at least 8 characters long.';
    if (!RegExp(r"^((?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,20})$")
        .hasMatch(password)) return 'Please enter a valid password.';
    return null;
  }
}

class PasswordConfirmationValidator {
  bool isValid(String password, String passwordConfrimation) {
    if (password != passwordConfrimation) return false;
    return true;
  }

  String getErrorMessage(String password, String passwordConfirmation) {
    if (password != passwordConfirmation) return 'Passwords do not match.';
    return null;
  }
}

class EmailAndPasswordValidator {
  EmailValidator emailValidator = EmailValidator();
  PasswordValidator passwordValidator = PasswordValidator();
  PasswordConfirmationValidator passwordConfirmationValidator =
      PasswordConfirmationValidator();
}
