// ignore_for_file: public_member_api_docs, avoid_print, unused_element

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:work_studio/app/login/login.dart';
import 'package:work_studio/app/main/layouts/layout_page.dart';
import 'package:work_studio/app/partials/appbar/main_appbar.dart';
import 'package:work_studio/app/partials/tools/delete_popup_box.dart';
import 'package:work_studio/app/storage/variables.dart';

class Homepage extends StatefulWidget {
  final String mainURL;
  const Homepage({Key? key, this.cookieManager, required this.mainURL})
      : super(key: key);

  final CookieManager? cookieManager;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final WebViewController _webViewController;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: mainBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size(60, 45),
          child: MainAppbar(
            webViewController: _controller,
            logoutMethod: () {
              logoutUser();
            },
          ),
        ),
        body: WebView(
          initialUrl: widget.mainURL,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.future.then(
              (value) => _webViewController = value,
            );
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            // log(progress.toString());
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(mainApplicationURL + "/login")) {
              goToLoginpage(context);
              return NavigationDecision.prevent;
            }
            // log(request.url.toString());

            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            // log(url.toString());
            navigateToNativeLogin(url, context);
          },
          onPageFinished: (String url) {
            // log(url.toString());
          },
          gestureNavigationEnabled: true,
          backgroundColor: mainBackgroundColor,
        ),
        // bottomNavigationBar: BotttomNavigationBar(
        //   webViewController: _controller,
        // ),
      ),
      onWillPop: () => _goBack(context),
    );
  }

//---------------------------------------------------------------------------------

  void goToLoginpage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (Route<dynamic> route) => false);
  }

//---------------------------------------------------------------------------------
  void navigateToNativeLogin(String url, BuildContext context) {
    if (url == "https://network.tryzent.com/login" ||
        url == "http://workstudio.io/login") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (Route<dynamic> route) => false);
    }
  }

//---------------------------------------------------------------------------------
  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          return FloatingActionButton(
            onPressed: () async {
              String? url;
              if (controller.hasData) {
                url = await controller.data!.currentUrl();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    controller.hasData
                        ? 'Favorited $url'
                        : 'Unable to favorite',
                  ),
                ),
              );
            },
            child: const Icon(Icons.favorite),
          );
        });
  }

//---------------------------------------------------------------------------------
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _webViewController.canGoBack()) {
      await _webViewController.goBack();
      return Future.value(false);
    } else {
      return _onBackPressed();
    }
  }

  //---------------------------------------------------------------------------------
  Future<bool> _onBackPressed() async {
    return await buildDeleteDialogBox(
      context: context,
      titleText: 'Alert!',
      subTitleText: 'Are you sure to exit ?',
      successText: 'EXIT',
      cancelText: 'CANCEL',
      okFunction: () {
        Navigator.of(context).pop(true);
      },
      cancleFunction: () {
        Navigator.of(context).pop(false);
      },
    );
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
}
