import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:work_studio/app/helpers/webview_navigation_control.dart';

class BotttomNavigationBar extends StatefulWidget {
  final Completer<WebViewController> webViewController;
  final CookieManager? cookieManager;

  const BotttomNavigationBar({
    Key? key,
    required this.webViewController,
    this.cookieManager,
  }) : super(key: key);
  @override
  _BotttomNavigationBarState createState() => _BotttomNavigationBarState();
}

class _BotttomNavigationBarState extends State<BotttomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.indigo,
      child: NavigationControls(widget.webViewController.future),
    );
  }

  //--------------------------------------------------------------

}
