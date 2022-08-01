// ignore_for_file: avoid_print
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_studio/app/main/layouts/layout_page.dart';
import 'package:work_studio/app/main/screens/google_meet_sdk.dart';
import 'package:work_studio/app/main/screens/zoom_meet_sdk.dart';
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
    super.initState();
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      log(url);

      if (url.contains("/login")) {
        logoutUser();
      } else if (url.contains("/logout")) {
        clearLocalStorage();
      } else if (url.contains("/native-meeting-sdk/google-meeting")) {
        navigateToGoogleMeetSDKPage();
      } else if (url.contains("/native-meeting-sdk/zoom-meeting")) {
        navigateToZoomMeetingSDKPage();
      } else {
        log(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return webviewScaffoldWidget(mainURL: widget.mainURL);
  }

//---------------------------------------------------------------------------------
  WebviewScaffold webviewScaffoldWidget({required String mainURL}) {
    return WebviewScaffold(
      url: mainURL,
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
        //  child: pulseProcressbar(screenSize, 80),
        child: const Center(
          child: Text(
            'Loading...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF656565),
            ),
          ),
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

  void clearLocalStorage() async {
    final SharedPreferences _preferences = await _sharedPreferences;
    await _preferences.clear();
  }

  void navigateToGoogleMeetSDKPage() {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.close();

    Navigator.push(
      context,
      PageTransition(
        child: const GoogleMeetSDK(),
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void navigateToZoomMeetingSDKPage() {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.close();

    Navigator.push(
      context,
      PageTransition(
        child: const ZoomMeetingSDK(),
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 300),
      ),
    );
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
