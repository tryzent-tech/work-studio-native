// ignore_for_file: public_member_api_docs, avoid_print, unused_element

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:work_studio/app/login/login.dart';
import 'package:work_studio/app/partials/appbar/main_appbar.dart';
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

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  void getCurrentURL() async {
    _webViewController.goBack();
    var url = await _webViewController.currentUrl();
    log(url.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(1, 237, 242, 246),
        appBar: PreferredSize(
          preferredSize: const Size(60, 0),
          child: MainAppbar(
            webViewController: _controller,
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
            log(progress.toString());
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(mainApplicationURL + "/login")) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false);
              return NavigationDecision.prevent;
            }
            log(request.toString());
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            log(url.toString());
            navigateToNativeLogin(url, context);
          },
          onPageFinished: (String url) {
            getCurrentURL();
            log(url.toString());
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
      ),
      onWillPop: () => _goBack(context),
    );
  }

//---------------------------------------------------------------------------------
  void navigateToNativeLogin(String url, BuildContext context) {
    if (url == "https://network.tryzent.com/login" ||
        url == "http://workstudio.io/login") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
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
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
  //---------------------------------------------------------------------------------
}