import 'package:chaty_app/app/sign_in/validators.dart';
import 'package:flutter/foundation.dart';

import '../../services/auth.dart';
import '../../constants/strings.dart';

enum SignInFormType {
  signIn,
  register,
}

class SignInModel with ChangeNotifier, EmailAndPasswordValidator {
  SignInModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.formType = SignInFormType.signIn,
    this.isLoading = false,
    this.passwordIsHidden = true,
    this.isSubmitted = false,
  });

  final AuthBase auth;
  String email;
  String password;
  String passwordConfirmation;
  SignInFormType formType;
  bool isLoading;
  bool passwordIsHidden;
  bool isSubmitted;

  String get mainButtonText {
    return isSignIn ? Strings.signIn : Strings.register;
  }

  String get toggleButtonText {
    return isSignIn ? Strings.changeToRegister : Strings.changeToSignin;
  }

  bool get isSignIn {
    return formType == SignInFormType.signIn;
  }

  String get emailErrorMessage {
    if (isSubmitted == true) {
      return emailValidator.isValid(email)
          ? null
          : emailValidator.getErrorMessage(email);
    }
    return null;
  }

  String get passwordErrorMessage {
    if (isSubmitted == true && !isSignIn) {
      return passwordValidator.isValid(password)
          ? null
          : passwordValidator.getErrorMessage(password);
    }
    return null;
  }

  String get passwordConfirmationErrorMessage {
    if (isSubmitted == true) {
      return passwordConfirmationValidator.isValid(
              password, passwordConfirmation)
          ? null
          : passwordConfirmationValidator.getErrorMessage(
              password, passwordConfirmation);
    }
    return null;
  }

  bool get canSignIn {
    if (formType == SignInFormType.signIn) return emailValidator.isValid(email);
    if (formType == SignInFormType.register)
      return emailValidator.isValid(email) &&
          passwordValidator.isValid(password) &&
          passwordConfirmationValidator.isValid(password, passwordConfirmation);
    else
      return false;
  }

  Future<void> submit() async {
    _updateWith(
      isLoading: true,
      isSubmitted: true,
    );
    if (!canSignIn) {
      _updateWith(isLoading: false);
      return;
    }
    try {
      formType == SignInFormType.signIn
          ? await auth.signIn(email, password)
          : await auth.register(email, password);
    } catch (error) {
      _updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    if (formType == SignInFormType.signIn) {
      _updateWith(
        formType: SignInFormType.register,
        email: '',
        password: '',
        passwordConfirmation: '',
        isSubmitted: false,
      );
      return;
    }
    _updateWith(
      formType: SignInFormType.signIn,
      email: '',
      password: '',
      passwordConfirmation: '',
    );
  }

  void updateEmail(String email) {
    _updateWith(email: email);
  }

  void updatePassword(String password) {
    _updateWith(password: password);
  }

  void updatePasswordConfirmation(String passwordConfirmation) {
    _updateWith(passwordConfirmation: passwordConfirmation);
  }

  void togglePasswordVisibility() {
    _updateWith(passwordIsHidden: !this.passwordIsHidden);
  }

  void _updateWith({
    String email,
    String password,
    String passwordConfirmation,
    SignInFormType formType,
    bool isLoading,
    bool passwordIsHidden,
    bool isSubmitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.passwordConfirmation =
        passwordConfirmation ?? this.passwordConfirmation;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.passwordIsHidden = passwordIsHidden ?? this.passwordIsHidden;
    this.isSubmitted = isSubmitted ?? this.isSubmitted;
    notifyListeners();
  }
}
