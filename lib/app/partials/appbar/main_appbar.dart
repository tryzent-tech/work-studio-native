import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainAppbar extends StatefulWidget {
  final Completer<WebViewController> webViewController;
  final CookieManager? cookieManager;

  const MainAppbar({
    Key? key,
    required this.webViewController,
    this.cookieManager,
  }) : super(key: key);
  @override
  _MainAppbarState createState() => _MainAppbarState();
}

class _MainAppbarState extends State<MainAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.only(left: 5),
        child: const Icon(
          FontAwesomeIcons.infinity,
          color: Colors.white,
        ),
      ),
      title: const Text(
        "Work Studio",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      leadingWidth: 25,
      elevation: 0.0,
      shadowColor: Colors.white,
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.amber,
      toolbarHeight: 60,
      titleSpacing: 20,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
