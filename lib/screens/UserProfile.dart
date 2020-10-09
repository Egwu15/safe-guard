import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatelessWidget {
  @override
  UserProfile({Key key, this.uid}) : super(key: key);
  final String uid;
  Widget build(BuildContext context) {
    //style of the Texts in this page

    var style = TextStyle(fontSize: 17.0);

    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('user_details')
            .document(uid)
            .snapshots(),
        builder: (context, snapshot) {
          print(uid);
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else
            return Scaffold(
              appBar: AppBar(
                title: Text('User Profile'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(snapshot.data['uploadedfileURL']),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Name: ' + snapshot.data['name'],
                          style: style,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Address: ' + snapshot.data['address'] ?? '',
                          style: style,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Date of birth: ' + snapshot.data['dob'] ?? '',
                          style: style,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Email ' + snapshot.data['email'] ?? '',
                          style: style,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Gender: ' + snapshot.data['gender'] ?? '',
                          style: style,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Nim: ' + snapshot.data['nim'] ?? '',
                          style: style,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Phone number: ' + snapshot.data['phone'] ?? '',
                          style: style,
                        ),
                        SizedBox(height: 10.0),
                      ]),
                ),
              ),
            );
        },
      ),
    );
  }
}
// // if (snapshot.hasData && snapshot.data['isPolice'] == true) {
// //   return PolicePage( imageURL:snapshot.data['uploadedfileURL'].toString() ,);
// //   //Todo: police page

// } else
