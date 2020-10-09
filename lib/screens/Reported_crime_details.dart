import 'package:flutter/material.dart';
import 'package:safeguard/screens/UserProfile.dart';
import 'package:safeguard/screens/map_page.dart';
import 'package:safeguard/screens/user_details_page.dart';
import 'package:safeguard/screens/videoPlayer.dart';

class ReportedCrimeDetails extends StatelessWidget {
  ReportedCrimeDetails(
      {Key key,
      this.image,
      this.reportedTime,
      this.address,
      this.dateOfComplain,
      this.descriptionOfOffence,
      this.nameOfOffence,
      this.offenderName,
      this.reportersName,
      this.ageOfOffender,
      this.genderOfOffender,
      this.colorOfOffender,
      this.latitude,
      this.longitude,
      this.userId,
      this.video})
      : super(key: key);
  final String image;
  final String reportedTime;
  String address;
  final String dateOfComplain;
  final String descriptionOfOffence;
  final String nameOfOffence;
  final String offenderName;
  final String reportersName;
  final String ageOfOffender;
  final String genderOfOffender;
  final String colorOfOffender;
  final double latitude;
  final double longitude;
  final String userId;
  final String video;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 300,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                              nameOfOffence,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500),
                            ) ??
                            'not showing',
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'The aledged offence was commited  on ' +
                              dateOfComplain +
                              ' at ' +
                              address +
                              ' and reported on ' +
                              reportedTime +
                              ' by ' +
                              reportersName,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
                elevation: 5.0,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                              offenderName,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                            ) ??
                            'not showing',
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'The suspect is ' +
                              ageOfOffender +
                              ', ' +
                              genderOfOffender +
                              ', ' +
                              colorOfOffender +
                              '.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
                elevation: 5.0,
              ),
              SizedBox(height: 20.0),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print(userId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfile(
                                uid: userId,
                              ),
                            ));
                      },
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                elevation: 5.0,
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print(userId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoApp(video: video,)
                            ));
                      },
                      child: Text(
                        'Video',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                elevation: 5.0,
              ),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapPage(
                          longitude: latitude,
                          latitude: latitude,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.location_on),
                  label: Text('Map')),
            ],
          ),
        ),
      ),
    );
  }
}
