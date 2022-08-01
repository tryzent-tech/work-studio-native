import 'package:flutter/material.dart';
import 'package:work_studio/app/partials/appbar/main_appbar.dart';

class GoogleMeetSDK extends StatefulWidget {
  const GoogleMeetSDK({Key? key}) : super(key: key);

  @override
  State<GoogleMeetSDK> createState() => _GoogleMeetSDKState();
}

class _GoogleMeetSDKState extends State<GoogleMeetSDK> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAdvanceWebpageAppbar(onLogout: () {}, onRefresh: () {}),
      body: Center(
        child: Text(
          "Google Meeting SDK",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
      ),
    );
  }
}
