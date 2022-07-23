import 'package:flutter/material.dart';
import 'package:work_studio/app/main/screens/homepage.dart';
import 'package:work_studio/app/partials/tools/delete_popup_box.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({
    Key? key,
  }) : super(key: key);
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        child: Scaffold(
          body: Builder(builder: (context) {
            return const Homepage(
              mainURL: 'https://network.tryzent.com/',
            );
          }),
        ),
        onTap: () {
          tapOnWholeScreen(context);
        },
      ),
      onWillPop: () {
        return _onBackPressed();
      },
    );
  }

//---------------------------------------------------------------------------------
  void tapOnWholeScreen(BuildContext context) {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
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
}
