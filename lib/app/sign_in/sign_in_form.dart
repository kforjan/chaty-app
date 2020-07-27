import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../constants/strings.dart';
import '../../services/auth.dart';
import 'sign_in_model.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({@required this.model});

  final SignInModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<SignInModel>(
      create: (context) => SignInModel(auth: auth),
      child: Consumer<SignInModel>(
        builder: (context, model, _) => SignInForm(
          model: model,
        ),
      ),
    );
  }

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmationFocusNode = FocusNode();

  SignInModel get model => widget.model;

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _passwordEditingComplete() {
    if (!model.isSignIn)
      FocusScope.of(context).requestFocus(_passwordConfirmationFocusNode);
    FocusScope.of(context).unfocus();
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmationController.clear();
  }

  Future<void> _submit() async {
    try {
      await model.submit();
    } on PlatformException catch (error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Something went wrong!'),
              content: Text(error.message),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
    }
  }

  List<Widget> _buildChildren() {
    return [
      Text(
        Strings.chaty,
        style: TextStyle(
            fontSize: 40,
            fontFamily: 'Lora',
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.blue),
      ),
      SizedBox(height: 10),
      _buildEmailTextField(),
      _buildPasswordTextField(),
      !model.isSignIn ? _buildConfirmPasswordTextField() : Container(),
      SizedBox(height: 40),
      RaisedButton(
        child: Text(model.mainButtonText),
        onPressed: model.isLoading ? null : _submit,
      ),
      SizedBox(height: 10),
      FlatButton(
        child: Text(model.toggleButtonText),
        onPressed: model.isLoading ? null : _toggleFormType,
      ),
    ];
  }

  TextField _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
          labelText: Strings.email,
          hintText: Strings.emailHint,
          helperText: '',
          errorText: model.emailErrorMessage),
      onChanged: (value) => model.updateEmail(value.trim()),
      onEditingComplete: _emailEditingComplete,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      controller: _emailController,
      focusNode: _emailFocusNode,
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: Strings.password,
        suffixIcon: IconButton(
          icon: Icon(
              model.passwordIsHidden ? Icons.visibility : Icons.visibility_off),
          onPressed: model.togglePasswordVisibility,
        ),
        helperText: Strings.passwordHint,
        errorText: model.passwordErrorMessage,
      ),
      onChanged: (value) => model.updatePassword(value.trim()),
      onEditingComplete: _passwordEditingComplete,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: model.passwordIsHidden,
      textInputAction:
          model.isSignIn ? TextInputAction.done : TextInputAction.next,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
    );
  }

  TextField _buildConfirmPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: Strings.confirmPassword,
        helperText: '',
        errorText: model.passwordConfirmationErrorMessage,
      ),
      onChanged: (value) => model.updatePasswordConfirmation(value.trim()),
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: model.passwordIsHidden,
      textInputAction: TextInputAction.done,
      controller: _passwordConfirmationController,
      focusNode: _passwordConfirmationFocusNode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildChildren(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
  }
}
