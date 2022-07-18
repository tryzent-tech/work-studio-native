import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:work_studio/app/helpers/webview_navigation_control.dart';

import '../../helpers/webview_helper.dart';

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
        padding: const EdgeInsets.only(left: 20),
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
      leadingWidth: 40,
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
      actions: <Widget>[
        NavigationControls(widget.webViewController.future),
        SampleMenu(widget.webViewController.future, widget.cookieManager),
      ],
    );
  }
}
