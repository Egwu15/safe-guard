import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:safeguard/auth/app.dart';
import 'package:safeguard/components/sidebar.dart';
import 'package:meta/meta.dart';

class HomePage extends StatelessWidget {
  final FirebaseUser user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  HomePage({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/bbb.jpg',
                      height: 100,
                    ),
                    Text(user.phoneNumber)
                  ],
                ),
              ),
//

              SideBarList(
                onPress: () {
                  Navigator.pop(context);
                },
                textTitle: 'Report case',
                iconWidget: Icon(Icons.library_books),
              ),
              SideBarList(
                onPress: () {
                  Navigator.pop(context);
                },
                textTitle: 'Wanted',
                iconWidget: Icon(Icons.person),
              ),
              SideBarList(
                onPress: () {
                  Navigator.pop(context);
                },
                textTitle: 'Help Lines',
                iconWidget: Icon(Icons.call),
              ),
              SideBarList(
                onPress: () {
                  _firebaseAuth.signOut();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => App()));
                },
                textTitle: 'Sign out',
                iconWidget: Icon(Icons.person),
              ),
            ],
          ),
        ),
        appBar: AppBar(),
        body: Container());
  }
}

//  Column(
//         children: <Widget>[
//           RaisedButton(
//             child: Text("Sign out"),
//             onPressed: () {
//               _firebaseAuth.signOut();
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => App()));
//             },
//           ),
//           Center(
//             child: Text(user.phoneNumber),
//           ),
//         ],
//       ),
