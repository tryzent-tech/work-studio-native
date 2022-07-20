import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_studio/app/login/login.dart';
import 'package:work_studio/app/provider/google_signin_provider.dart';

import 'main/layouts/layout_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return GoggleSignInProvider();
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Work Studio",
        home: Material(
          child: LoginPage(),
        ),
      ),
    );
  }
}
