import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('user_details');

  Future<void> updateUserData(String name, String strength) async {
    return await brewCollection.document(uid).setData({

      'name': name,
      'strength': strength,
    });
  }

}