// ignore_for_file: unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture, {Key? key})
      : super(key: key);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot<WebViewController> snapshot,
      ) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            navigationBackButton(webViewReady, controller, context),
            pageRefreshButton(webViewReady, controller),
            navigationForwardButton(webViewReady, controller, context),
          ],
        );
      },
    );
  }

//---------------------------------------------------------------------------------
  navigationBackButton(
    bool webViewReady,
    WebViewController? controller,
    BuildContext context,
  ) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: !webViewReady
          ? null
          : () async {
              if (await controller!.canGoBack()) {
                await controller.goBack();
              } else {
                showSnackBar(context, "No back history item");
                return;
              }
            },
    );
  }

//---------------------------------------------------------------------------------
  IconButton pageRefreshButton(
      bool webViewReady, WebViewController? controller) {
    return IconButton(
      icon: const Icon(Icons.replay, color: Colors.white),
      onPressed: !webViewReady
          ? null
          : () {
              controller!.reload();
            },
    );
  }

  //---------------------------------------------------------------------------------
  navigationForwardButton(
      bool webViewReady, WebViewController? controller, BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_forward, color: Colors.white),
      onPressed: !webViewReady
          ? null
          : () async {
              if (await controller!.canGoForward()) {
                await controller.goForward();
              } else {
                showSnackBar(context, "No forward history item");
                return;
              }
            },
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade900,
      ),
    );
  }
  //---------------------------------------------------------------------------------
}
