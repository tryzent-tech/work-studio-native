// ignore_for_file: avoid_print
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_studio/app/main/layouts/layout_page.dart';
import 'package:work_studio/app/partials/appbar/main_appbar.dart';
import 'package:work_studio/app/storage/variables.dart';

String selectedUrl = 'https://flutter.io';

class AdvanceHomepage extends StatefulWidget {
  final String mainURL;

  const AdvanceHomepage({Key? key, required this.mainURL}) : super(key: key);

  @override
  State<AdvanceHomepage> createState() => _AdvanceHomepageState();
}

class _AdvanceHomepageState extends State<AdvanceHomepage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  void initState() {
    flutterWebViewPlugin.onUrlChanged.listen((url) {
      log("Advance Webpage URL ->" + url.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.mainURL,
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
      appBar: buildAdvanceWebpageAppbar(
        onLogout: () {
          logoutUser();
        },
        onRefresh: () {
          flutterWebViewPlugin.reload();
        },
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: false,
      initialChild: Container(
        color: mainBackgroundColor,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
      // bottomNavigationBar: bottomNavbar(),
    );
  }

//---------------------------------------------------------------------------------
  BottomAppBar bottomNavbar() {
    return BottomAppBar(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              flutterWebViewPlugin.goBack();
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              flutterWebViewPlugin.goForward();
            },
          ),
          IconButton(
            icon: const Icon(Icons.autorenew),
            onPressed: () {
              flutterWebViewPlugin.reload();
            },
          ),
        ],
      ),
    );
  }

  void logoutUser() async {
    final SharedPreferences _preferences = await _sharedPreferences;
    bool clear = await _preferences.clear();
    if (clear) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LayoutPage(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }
}

//---------------------------------------------------------------------------------
// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();
