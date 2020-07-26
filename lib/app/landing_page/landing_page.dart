import 'package:chaty_app/app/home_page/home_page.dart';
import 'package:chaty_app/app/sign_in/sign_in_page.dart';
import 'package:chaty_app/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthBase>(context);
    return StreamBuilder(
      stream: _auth.onAuthChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User _user = snapshot.data;
          if (_user == null) {
            return SignInPage();
          }
          return HomePage();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
