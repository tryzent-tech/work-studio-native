// ignore_for_file: file_names

import 'package:flutter/material.dart';

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
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo.shade700,
            ),
            accountName: const Text("Your Name"),
            accountEmail: const Text("youremail@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.indigo.shade900,
              child: Text(
                "NAME",
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            leading: Icon(
              Icons.home,
              color: Colors.indigo.shade900,
            ),
            autofocus: true,
            hoverColor: Colors.grey.shade300,
            focusColor: Colors.white10,
            dense: true,
            onLongPress: () {},
            onTap: () {},
            // tileColor: Colors.blue,
          ),
          Divider(
            color: Colors.blue.shade900,
            thickness: 1.0,
            endIndent: 3,
            indent: 3,
          ),
          ListTile(
            title: const Text(
              "Gallary",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            leading: Icon(
              Icons.image,
              color: Colors.indigo.shade900,
            ),
            autofocus: true,
            hoverColor: Colors.grey.shade300,
            focusColor: Colors.white10,
            dense: true,
            onLongPress: () {},
            onTap: () {},
            // tileColor: Colors.blue,
          ),
          Divider(
            color: Colors.blue.shade900,
            thickness: 1.0,
            endIndent: 3,
            indent: 3,
          ),
          ListTile(
            title: const Text(
              "Document",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            leading: Icon(
              Icons.document_scanner,
              color: Colors.indigo.shade900,
            ),
            autofocus: true,
            hoverColor: Colors.grey.shade300,
            focusColor: Colors.white10,
            dense: true,
            onLongPress: () {},
            onTap: () {},
            // tileColor: Colors.blue,
          ),
          Divider(
            color: Colors.blue.shade900,
            thickness: 1.0,
            endIndent: 3,
            indent: 3,
          ),
          ListTile(
            title: const Text(
              "Account",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            leading: Icon(
              Icons.account_balance,
              color: Colors.indigo.shade900,
            ),
            autofocus: true,
            hoverColor: Colors.grey.shade300,
            focusColor: Colors.white10,
            dense: true,
            onLongPress: () {},
            onTap: () {},
            // tileColor: Colors.blue,
          ),
          Divider(
            color: Colors.blue.shade900,
            thickness: 1.0,
            endIndent: 3,
            indent: 3,
          ),
          ListTile(
            title: const Text(
              "About Us",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            leading: Icon(
              Icons.people,
              color: Colors.indigo.shade900,
            ),
            autofocus: true,
            hoverColor: Colors.grey.shade300,
            focusColor: Colors.white10,
            dense: true,
            onLongPress: () {},
            onTap: () {},
            // tileColor: Colors.blue,
          ),
          Divider(
            color: Colors.blue.shade900,
            thickness: 1.0,
            endIndent: 3,
            indent: 3,
          ),
        ],
      ),
    );
  }
}
