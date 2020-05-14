import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:safeguard/screens/complain_page.dart';
import 'package:safeguard/services/authentication.dart';
import 'Reported_crime_details.dart';
import 'package:safeguard/components/sidebar.dart';

import 'Your_account.dart';

// class Homepage extends StatefulWidget {

//     Homepage ({Key key,  this.uid}) : super(key: key);

//   final String uid;

//   @override
//   HomepageState createState() => HomepageState();
// }

// class HomepageState extends State<Homepage> {
// HomepageState({Key key,  this.uid}) : super(key: key);
// final String uid;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(title: 'Wanted',uid: userid,),
//     );
//   }
// }

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title, this.uid, this.imageURL})
      : super(key: key);

  final String title;
  final String uid;
  final String imageURL;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    String image =
        "https://cdn.clipart.email/7eb444c29059365a94293fafa74def60_www-vector-url-icon-picture-2845942-www-vector-url-icon_512-511.png";

    String dateOfComplain;
    String descriptionOfOffence;
    String nameOfOffence;
    String offenderName;
    String reportersName;
    Timestamp timeReported;
    String ageOfOffender;
    String genderOfOffender;
    String address;
    String dateReported;
    String colorOfOffender;
    double latitude;
    double longitiude;
    String imageUrl;
    

    void submit() {
      address = document['address of crime'];
      timeReported = document['timeNow'] ?? '';

      DateTime d = timeReported.toDate();
      dateReported = DateFormat.yMMMd().add_jm().format(d).toString();

      image = document['imageUrl'] ?? image;
      ageOfOffender = document['ageOfOffender'] ?? '';
      colorOfOffender = document['colorOfOffender'] ?? '';
      genderOfOffender = document['gender'] ?? '';
      offenderName = document['offenderName'] ?? '';
      reportersName = document['reportersName'] ?? '';
      nameOfOffence = document['nameOfOffence'] ?? '';
      dateOfComplain = document['dateOfComplain'] ?? '';
      descriptionOfOffence = document['descriptionOfOffence'] ?? '';
      var latitudeString = document['latitude'] ?? '';
      var longitiudeString = document['longitude'] ?? '';
      latitude = double.parse(latitudeString);
      longitiude = double.parse(longitiudeString);
    }

    return ListTile(
      title: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(document['imageUrl'] ?? image)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      document['nameOfOffence'] ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 17.0),
                    ),
                    Text(
                      document['address of crime'] ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      document['dateOfComplain'].toString() ?? "",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        submit();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportedCrimeDetails(
              image: image,
              reportedTime: dateReported,
              address: address,
              dateOfComplain: dateOfComplain,
              descriptionOfOffence: descriptionOfOffence,
              nameOfOffence: nameOfOffence,
              offenderName: offenderName,
              reportersName: reportersName,
              ageOfOffender: ageOfOffender,
              genderOfOffender: genderOfOffender,
              colorOfOffender: colorOfOffender,
              latitude: latitude,
              longitude: longitiude,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplainPage(
                userId: uid,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Reported cases'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(imageURL),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageURL), fit: BoxFit.cover),
              ),
            ),
            SideBarList(
              textTitle: 'Report Case',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplainPage(
                      userId: uid,
                    ),
                  ),
                );
              },
            ),
            SideBarList(
              textTitle: 'Account',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateDetails(
                            auth: Auth(),
                            userId: uid,
                          )),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('case_details')
              .document('UpR6MIzxikZQtMv6gAv3wyE4Q7G2')
              .collection('Reported').where('userid', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          }

// This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
