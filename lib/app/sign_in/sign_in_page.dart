import 'package:flutter/material.dart';

import '../../common_widgets/background_decoration.dart';
import 'sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundDecoration(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: SignInForm.create(context),
          ),
        ),
      ),
    );
  }
}
