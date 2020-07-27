import 'package:chaty_app/common_widgets/background_decoration.dart';
import 'package:chaty_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDecoration(
        child: Center(
          child: RaisedButton(
            child: Text('log off'),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ),
      ),
    );
  }
}
