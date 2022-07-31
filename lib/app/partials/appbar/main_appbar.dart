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
AppBar workStudioLogoAppbar() {
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
AppBar loginPageAppbar() {
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
    centerTitle: true,
    shadowColor: Colors.white,
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.amber,
    toolbarHeight: 55,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}

AppBar buildAdvanceWebpageAppbar(
    {required Function() onLogout, required Function() onRefresh}) {
  return AppBar(
    leadingWidth: 0,
    leading: Container(),
    title: Container(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Container(
            child: const Icon(
              FontAwesomeIcons.infinity,
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(left: 10, right: 15),
          ),
          const Text(
            "Work Studio",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
    titleSpacing: 0,
    elevation: 20,
    shadowColor: Colors.white,
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.amber,
    toolbarHeight: 45,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    // actions: [
    //   IconButton(
    //     onPressed: onRefresh,
    //     splashRadius: 18,
    //     icon: const Icon(
    //       FontAwesomeIcons.rotateRight,
    //       size: 20,
    //       color: Colors.white,
    //     ),
    //   ),
    //   IconButton(
    //     onPressed: onLogout,
    //     splashRadius: 18,
    //     icon: const Icon(
    //       FontAwesomeIcons.powerOff,
    //       size: 20,
    //       color: Colors.white,
    //     ),
    //   ),
    // ],
  );
}
