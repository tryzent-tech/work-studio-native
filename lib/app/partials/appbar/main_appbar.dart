import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainAppbar extends StatefulWidget {
  final Completer<WebViewController> webViewController;
  final CookieManager? cookieManager;

  final Function() logoutMethod;

  const MainAppbar({
    Key? key,
    required this.webViewController,
    this.cookieManager,
    required this.logoutMethod,
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
      actions: [
        logoutWidget(),
      ],
    );
  }

  Container logoutWidget() {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: widget.logoutMethod,
            iconSize: 20,
            icon: const Icon(
              FontAwesomeIcons.powerOff,
              color: Colors.white,
            ),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}

//---------------------------------------------------------------------------------
AppBar buildAppBar1() {
  return AppBar(
    title: Container(
      child: const Image(
        image: AssetImage(
          "assets/images/ws-long-logo.png",
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
    ),
    backgroundColor: const Color.fromARGB(255, 245, 245, 245),
    elevation: 20,
    centerTitle: true,
    shadowColor: Colors.transparent,
    toolbarHeight: 60,
  );
}

//---------------------------------------------------------------------------------
AppBar buildAppBar2() {
  return AppBar(
    title: Container(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: const Icon(
              FontAwesomeIcons.infinity,
              color: Colors.white,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const Text(
            "Work Studio",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
    elevation: 20,
    shadowColor: Colors.white,
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.amber,
    toolbarHeight: 40,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}
