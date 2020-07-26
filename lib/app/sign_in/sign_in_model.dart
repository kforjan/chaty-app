import 'package:flutter/foundation.dart';

import '../../services/auth.dart';
import '../../constants/strings.dart';

enum SignInFormType {
  signIn,
  register,
}

class SignInModel with ChangeNotifier {
  SignInModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.formType = SignInFormType.signIn,
    this.isLoading = false,
    this.passwordIsHidden = true,
  });

  final AuthBase auth;
  String email;
  String password;
  SignInFormType formType;
  bool isLoading;
  bool passwordIsHidden;

  String get mainButtonText {
    return isSignIn ? Strings.signIn : Strings.register;
  }

  String get toggleButtonText {
    return isSignIn ? Strings.changeToRegister : Strings.changeToSignin;
  }

  bool get isSignIn {
    return formType == SignInFormType.signIn;
  }

  void toggleFormType() {
    if (formType == SignInFormType.signIn) {
      _updateWith(formType: SignInFormType.register);
      return;
    }
    _updateWith(formType: SignInFormType.signIn);
  }

  void togglePasswordVisibility() {
    _updateWith(passwordIsHidden: !this.passwordIsHidden);
  }

  void _updateWith({
    String email,
    String password,
    SignInFormType formType,
    bool isLoading,
    bool passwordIsHidden,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.passwordIsHidden = passwordIsHidden ?? this.passwordIsHidden;
    notifyListeners();
  }
}
