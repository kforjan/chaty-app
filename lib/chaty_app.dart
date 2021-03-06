import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/landing_page/landing_page.dart';
import 'services/auth.dart';

class ChatyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Material App',
        home: Scaffold(
          body: Center(
            child: LandingPage(),
          ),
        ),
      ),
    );
  }
}
