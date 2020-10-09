import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'colo\\';
import 'package:safeguard/screens/home_page.dart';
import 'package:safeguard/screens/police.dart';
import 'package:safeguard/screens/user_details_page.dart';

class   PoliceCheck extends StatefulWidget {
  PoliceCheck({Key key, this.userid}) : super(key: key);
  final userid;

  @override
  _PoliceCheckState createState() => _PoliceCheckState();
}

class _PoliceCheckState extends State<PoliceCheck> {
  _PoliceCheckState({Key key, this.userid});
  final userid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('user_details')
            .document(widget.userid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
          if (snapshot.hasData)
            // return  UserDetailsPage(userId: widget.userid);
          if (snapshot.hasData && snapshot.data['isPolice'] == true) {
            return PolicePage( imageURL:snapshot.data['uploadedfileURL'].toString() ,);
            //Todo: police page
          } else if (snapshot.hasData &&
              snapshot.data['isRegistered'] != true) {
            return  UserDetailsPage(userId: widget.userid);
          } else
            return HomePage(
             imageURL: snapshot.data['uploadedfileURL'].toString() ,
              uid: widget.userid,
            );
        },
      ),
    );
  }
}
