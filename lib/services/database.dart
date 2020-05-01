import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('user_details');

  Future<void> updateUserData(String name, String dob, String phone, String nim, String email, String gender) async {
    return await brewCollection.document(uid).setData({

      'name': name,
      'dob': dob,
      'phone': phone,
      'nim': nim,
      'email' : email,
      'gender': gender,

    });
  }

}

class ComplainDatabaseService {

  final String userid;
  ComplainDatabaseService({ this.userid });
  
  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('case_details');

  Future<void> updateUserData(String uid, String name, String offenderName, String dateOfComplain, String phone, String nim, String email, String genderOfOffender, String nameOfOffence, String descriptionOfOffence, Timestamp timeNow, String colorOfOffender) async {
    // return await brewCollection.document(userid).setData({
     return await brewCollection.document(uid).collection('Reported').document().setData({
       'userid': uid,
      'name': name,
      'offenderName' : offenderName,
      'dateOfComplain': dateOfComplain,
      'phone': phone,
      'nim': nim,
      'email' : email,
      'gender': genderOfOffender,
      
      'colorOfOffender' : colorOfOffender,
      'nameOfOffence' : nameOfOffence,
      'timeNow' : timeNow,
      'decriptionOfOffence': descriptionOfOffence,

      
      

    });
  }

}