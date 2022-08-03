import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:work_studio/app/storage/variables.dart';

class FlutterCustomTabs extends StatefulWidget {
  const FlutterCustomTabs({Key? key}) : super(key: key);

  @override
  State<FlutterCustomTabs> createState() => _FlutterCustomTabsState();
}

class _FlutterCustomTabsState extends State<FlutterCustomTabs> {
  @override
  void initState() {
    super.initState();
    launchCustomTab();
  }

  void launchCustomTab() {
    Future.delayed(const Duration(seconds: 1), () {
      _launchURL(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final theme = Theme.of(context);
    try {
      await launch(
        mainApplicationURL,
        customTabsOption: CustomTabsOption(
          toolbarColor: Colors.indigo,
          enableDefaultShare: true,
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
}
