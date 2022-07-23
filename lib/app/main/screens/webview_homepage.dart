// ignore_for_file: public_member_api_docs, avoid_print, unused_element

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:work_studio/app/login/login.dart';
import 'package:work_studio/app/partials/appbar/main_appbar.dart';

class WebViewHomepage extends StatefulWidget {
  final String mainURL;
  const WebViewHomepage({Key? key, this.cookieManager, required this.mainURL})
      : super(key: key);

  final CookieManager? cookieManager;

  @override
  State<WebViewHomepage> createState() => _WebViewHomepageState();
}

class _WebViewHomepageState extends State<WebViewHomepage> {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
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
            print('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            navigateLoginScreenIfOpenWebpageLoginpage(url, context);
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
        // bottomNavigationBar: BotttomNavigationBar(
        //   webViewController: _controller,
        // ),
      ),
    );
  }

//---------------------------------------------------------------------------------
  void navigateLoginScreenIfOpenWebpageLoginpage(
      String url, BuildContext context) {
    if (url == "https://network.tryzent.com/login" ||
        url == "http://workstudio.io/login") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

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
      _webViewController.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
