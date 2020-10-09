//import 'dart:io';
//
//
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//
//import 'package:path/path.dart';
//
//void main() {
//  runApp(WebUpload());
//}
//
//class WebUpload extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: ImagePickerPage(),
//    );
//  }
//}
//
//var _image;
//var _uploadedFileURL;
//var imageCaption;
//File doc;
//
//class ImagePickerPage extends StatefulWidget {
//  @override
//  _ImagePickerPageState createState() => _ImagePickerPageState();
//}
//
//class _ImagePickerPageState extends State<ImagePickerPage> {
// Image image;
//  @override
//  Widget build(BuildContext context) {
//    Future uploadFile() async {
//      StorageReference storageReference =
//          FirebaseStorage.instance.ref().child('profile/testImmage.png');
//      StorageUploadTask uploadTask = storageReference.putFile(doc);
//      await uploadTask.onComplete;
//      print('File Uploaded');
//      storageReference.getDownloadURL().then((fileURL) {
//        setState(() {
//          _uploadedFileURL = fileURL;
//          imageCaption = 'Image uploaded! submit';
//        });
//      });
//    }
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(image?.semanticLabel ?? ""),
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.open_in_browser),
//        onPressed: () async {
//
//          doc = _image as File;
//          uploadFile();
//          setState(() {
//            image = _image;
//          });
//        },
//      ),
//      body: Center(child: Text(imageCaption),
//
//
//        // children: <Widget>[
//        //   Center(
//        //     child: FlatButton(
//        //       onPressed: () {
//        //         uploadFile();
//        //       },
//        //       child: Text('upload'),
//        //     ),
//        //   ),
//        //   Text(imageCaption)
//        // ],
//      ),
//
//
//    );
//  }
//}
