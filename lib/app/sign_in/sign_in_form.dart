import 'package:flutter/material.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  SignInModel get model => widget.model;

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
      SizedBox(height: 20),
      _buildPasswordTextField(),
      !model.isSignIn ? SizedBox(height: 20) : Container(),
      !model.isSignIn ? _buildConfirmPasswordTextField() : Container(),
      SizedBox(height: 40),
      RaisedButton(
        child: Text(model.mainButtonText),
        onPressed: () {},
      ),
      SizedBox(height: 10),
      FlatButton(
        child: Text(model.toggleButtonText),
        onPressed: () {
          model.toggleFormType();
        },
      ),
    ];
  }

  TextField _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: Strings.email,
        hintText: Strings.emailHint,
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      controller: emailController,
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: Strings.password,
        suffixIcon: IconButton(
          icon: Icon(Icons.visibility),
          onPressed: model.togglePasswordVisibility,
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: model.passwordIsHidden,
      controller: passwordController,
    );
  }

  TextField _buildConfirmPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: Strings.confirmPassword,
      ),
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: model.passwordIsHidden,
      controller: passwordConfirmationController,
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
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
  }
}
