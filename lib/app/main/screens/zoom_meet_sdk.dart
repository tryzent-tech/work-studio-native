import 'package:flutter/material.dart';
import 'package:work_studio/app/partials/appbar/main_appbar.dart';

class ZoomMeetingSDK extends StatefulWidget {
  const ZoomMeetingSDK({Key? key}) : super(key: key);

  @override
  State<ZoomMeetingSDK> createState() => _ZoomMeetingSDKState();
}

class _ZoomMeetingSDKState extends State<ZoomMeetingSDK> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAdvanceWebpageAppbar(onLogout: () {}, onRefresh: () {}),
      body: Center(
        child: Text(
          "Zoom Meeting SDK",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
      ),
    );
  }
}
