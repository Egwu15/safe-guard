import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('user_details');

  Future<void> updateUserData(String name, String dob, String phone, String nim,
      String email, String gender, bool isPolice, bool isRegistered, String address ,String uploadedfileURL) async {
    return await brewCollection.document(uid).setData({
      'name': name,
      'dob': dob,
      'phone': phone,
      'nim': nim,
      'email': email,
      'gender': gender,
      'isPolice': isPolice,
      'isRegistered' : isRegistered,
      'uploadedfileURL' : uploadedfileURL,
      'address': address,
    });
  }


  Future<void> setPoliceAndRegister( bool isPolice, bool isRegistered) async {
    return await brewCollection.document(uid).setData({
    
      'isPolice': isPolice,
      'isRegistered' : isRegistered,
      
    });
  }
}

class ComplainDatabaseService {
  final String userid;
  ComplainDatabaseService({this.userid});

  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('case_details');

  Future<void> updateUserData(
    String userid,
    String reportersName,
    String offenderName,
    String dateOfComplain,
    String ageOfOffender,
    String addressOfCrime,
    String genderOfOffender,
    String nameOfOffence,
    String descriptionOfOffence,
    Timestamp timeNow,
    String colorOfOffender,
    String imageUrl,
    String longitude,
    String latitude,
     String videoUrl,
  ) async {
    // return await brewCollection.document(userid).setData({
    return await brewCollection
        .document('UpR6MIzxikZQtMv6gAv3wyE4Q7G2')
        .collection('Reported')
        .document()
        .setData({
      'userid': userid,
      'reportersName': reportersName,
      'offenderName': offenderName,
      'dateOfComplain': dateOfComplain,
      'ageOfOffender': ageOfOffender,
      'address of crime': addressOfCrime,
      'gender': genderOfOffender,
      'colorOfOffender': colorOfOffender,
      'nameOfOffence': nameOfOffence,
      'timeNow': timeNow,
      'decriptionOfOffence': descriptionOfOffence,
      'imageUrl': imageUrl,
      'longitude': longitude,
      'latitude': latitude,
      'videoUrl': videoUrl
    });
  }
}
