// ignore_for_file: file_names

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as customTab;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_studio/app/storage/variables.dart';

class MainSidebar extends StatefulWidget {
  const MainSidebar({
    Key? key,
  }) : super(key: key);
  @override
  _MainSidebarState createState() => _MainSidebarState();
}

class _MainSidebarState extends State<MainSidebar> {
  @override
  Widget build(BuildContext context) {
    return drawerManagement();
  }

  drawerManagement() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.indigo,
            ),
            accountName: const Text("Work Studio"),
            accountEmail: const Text("workstudio@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.indigo,
              child: Text(
                "WS",
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          buildSidebarButton(
            buttonText: 'Custom Tab',
            icon: FontAwesomeIcons.chrome,
            onPressed: () {
              _launchCustomTabURL(context);
            },
          ),
          buildDivider(),
          buildSidebarButton(
            buttonText: 'Work Studio',
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
            onPressed: () {
              _launchWorkStudionURL();
            },
          ),
          buildDivider(),
          buildSidebarButton(
            buttonText: 'Google Meet',
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
            onPressed: () {
              _launchGoogleMeetURL();
            },
          ),
          buildDivider(),
          buildSidebarButton(
            buttonText: 'Zoom Meeting',
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
            onPressed: () {
              _launchZoomMeetingURL();
            },
          ),
          buildDivider(),
        ],
      ),
    );
  }

//---------------------------------------------------------------------------------
  Divider buildDivider() {
    return const Divider(
      color: Color.fromARGB(255, 194, 194, 194),
      thickness: 1.0,
      endIndent: 3,
      indent: 3,
    );
  }

//---------------------------------------------------------------------------------
  ListTile buildSidebarButton({
    required IconData icon,
    required String buttonText,
    required Function() onPressed,
  }) {
    return ListTile(
      title: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: Color.fromARGB(255, 59, 59, 59),
        ),
      ),
      leading: Icon(
        icon,
        color: const Color.fromARGB(255, 93, 93, 93),
      ),
      visualDensity: const VisualDensity(vertical: -2),
      autofocus: true,
      hoverColor: Colors.grey.shade300,
      focusColor: Colors.white10,
      dense: true,
      onLongPress: () {},
      onTap: onPressed,
      // tileColor: Colors.blue,
    );
  }

//---------------------------------------------------------------------------------
  _launchWorkStudionURL() async {
    // ignore: deprecated_member_use
    if (await canLaunch(mainApplicationURL)) {
      // ignore: deprecated_member_use
      await launch(mainApplicationURL);
    } else {
      throw 'Could not launch $mainApplicationURL';
    }
  }

  _launchGoogleMeetURL() async {
    const url = 'https://meet.google.com/zza-afts-szz';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchZoomMeetingURL() async {
    const url =
        'https://us05web.zoom.us/j/84841031424?pwd=b0I1TUhnVnBQRFo1d3RQWktwVVZCQT09';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  //---------------------------------------------------------------------------------

  Future<void> _launchCustomTabURL(BuildContext context) async {
    final theme = Theme.of(context);
    try {
      await customTab.launch(
        mainApplicationURL,
        customTabsOption: customTab.CustomTabsOption(
          toolbarColor: Colors.indigo,
          enableDefaultShare: false,
          enableUrlBarHiding: false,
          showPageTitle: false,
          animation: customTab.CustomTabsSystemAnimation.slideIn(),
          extraCustomTabs: const <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: customTab.SafariViewControllerOption(
          preferredBarTintColor: theme.primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle:
              customTab.SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
