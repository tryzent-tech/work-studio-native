// ignore_for_file: avoid_print
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_studio/app/main/layouts/layout_page.dart';
import 'package:work_studio/app/main/screens/google_meet_sdk.dart';
import 'package:work_studio/app/main/screens/zoom_meet_sdk.dart';
import 'package:work_studio/app/partials/appbar/main_appbar.dart';
import 'package:work_studio/app/storage/local_storage.dart';
import 'package:work_studio/app/storage/variables.dart';

class AdvanceHomepage extends StatefulWidget {
  final String mainURL;

  const AdvanceHomepage({Key? key, required this.mainURL}) : super(key: key);

  @override
  State<AdvanceHomepage> createState() => _AdvanceHomepageState();
}

class _AdvanceHomepageState extends State<AdvanceHomepage>
    with WidgetsBindingObserver {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  double completeProgress = 1.0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    changeURLListner();
    getCurrentWEBViewURL();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('Application State = $state');
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return webviewScaffoldWidget(mainURL: widget.mainURL);
  }

//---------------------------------------------------------------------------------
  WebviewScaffold webviewScaffoldWidget({required String mainURL}) {
    return WebviewScaffold(
      url: mainURL,
      mediaPlaybackRequiresUserGesture: false,
      appBar: PreferredSize(
        preferredSize: const Size(60, 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildAdvanceWebpageAppbar(
                onLogout: () {
                  logoutUser();
                },
                onRefresh: () {
                  flutterWebViewPlugin.reload();
                },
              ),
              Container(
                padding: const EdgeInsets.all(0),
                child: LinearPercentIndicator(
                  lineHeight: 6,
                  animationDuration: 3000,
                  padding: const EdgeInsets.all(0),
                  percent: completeProgress,
                  animateFromLastPercent: true,
                  backgroundColor: mainBackgroundColor,
                  progressColor: const Color.fromARGB(255, 113, 165, 255),
                ),
              ),
            ],
          ),
        ),
      ),

      withZoom: true,
      withLocalStorage: true,
      hidden: false,
      initialChild: Container(
        color: mainBackgroundColor,
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

//---------------------------------------------------------------------------------
  void changeURLListner() {
    final flutterWebviewPlugin = FlutterWebviewPlugin();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("/login")) {
        logoutUser();
      } else if (url.contains("/logout")) {
        clearLocalStorage();
      } else if (url.contains(googleMeetWebSdkURL)) {
        navigateToGoogleMeetSDKPage();
      } else if (url.contains(zoomMeetingWebSdkURL)) {
        navigateToZoomMeetingSDKPage();
      } else if (url.contains(nativeSdkJoinMeetingURL)) {
        joinMeetingByCustomTab(meetingURL: url);
      } else {}
    });
  }

  //---------------------------------------------------------------------------------
  void joinMeetingByCustomTab({required String meetingURL}) {
    var stringURI = Uri.dataFromString(Uri.decodeFull(meetingURL));
    Map<String, String> params = stringURI.queryParameters;
    String? meetingURLString = params['meetingURL'];

    log(meetingURLString.toString());

    launchURLInCustomTab(context, meetingURLString.toString());
  }

//---------------------------------------------------------------------------------
  Future<void> launchURLInCustomTab(
      BuildContext context, String stringURL) async {
    final theme = Theme.of(context);
    try {
      await launch(
        stringURL,
        customTabsOption: CustomTabsOption(
          toolbarColor: Colors.indigo,
          enableDefaultShare: false,
          enableUrlBarHiding: true,
          showPageTitle: false,
          animation: CustomTabsSystemAnimation.slideIn(),
          extraCustomTabs: const <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: theme.primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //---------------------------------------------------------------------------------
  void getCurrentWEBViewURL() {
    LocalStorage _localStorage = LocalStorage();

    flutterWebViewPlugin.onProgressChanged.listen((double value) {
      log(value.toString());
      setState(() {
        completeProgress = value;
      });
      var jsFunction = 'window.location.href';

      final future = flutterWebViewPlugin.evalJavascript(jsFunction);

      future.then((String? currentPageURL) {
        if (value == 1.0) {
          _localStorage.setCurrentPageURL(currentPageURL.toString());
          getCurrentPageURL();
        }
      });
    });
  }

//---------------------------------------------------------------------------------
  void getCurrentPageURL() async {
    LocalStorage _localStorage = LocalStorage();
    String currentPageURL2 = await _localStorage.getCurrentPageURL();
    log(currentPageURL2);
  }
//---------------------------------------------------------------------------------

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
//---------------------------------------------------------------------------------

  void clearLocalStorage() async {
    final SharedPreferences _preferences = await _sharedPreferences;
    await _preferences.clear();
  }
//---------------------------------------------------------------------------------

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
//---------------------------------------------------------------------------------

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
//---------------------------------------------------------------------------------

}
