import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class FlutterCustomTabs extends StatefulWidget {
  const FlutterCustomTabs({Key? key}) : super(key: key);

  @override
  State<FlutterCustomTabs> createState() => _FlutterCustomTabsState();
}

class _FlutterCustomTabsState extends State<FlutterCustomTabs> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_context) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Custom Tabs Example'),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Center(
          child: TextButton(
            onPressed: () => _launchURL(_context),
            child: const Text(
              'Show Flutter homepage',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final theme = Theme.of(context);
    try {
      await launch(
        'https://network.tryzent.com/',
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
}
