import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:safeguard/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as Path;



import 'package:safeguard/services/web_upload.dart';
// void main() => runApp(new MyApp());

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage({Key key, this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Userdetails(
        title: 'Details',
        userId: userId,
      ),
    );
  }
}

class Userdetails extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Userdetails({
    Key key,
    this.title,
    this.userId,
  }) : super(key: key);
  final String title;
  final userId;

  @override
  _UserdetailsState createState() => new _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  _UserdetailsState({
    Key key,
    this.title,
    this.userId,
  });
  final String title;
  final userId;

  String name;
  String dob;
  String phone;
  String nim;
  String email;
  String gender;
  bool isPolice = false;
  String address;

 

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _genders = <String>['', 'Male', 'Female'];
  String _gender = '';

  final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  bool _isLoading = false;
  File _image;
  String profileImage;
  String imageCaption = '';
  File imageI;

  Future chooseFileFromGallery() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
        imageCaption = 'File selected, please upload';
      });
    });
  }

  Future chooseFileFromCamera() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image = image;
        imageCaption = 'File selected, please upload';
      });
    });
  }

  bool isRegistered = true;
  String _uploadedFileURL;

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        imageCaption = 'Image uploaded! submit';
      });
    });
  }

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    var mobileUpload = _image != null
        ? Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  _image.path,
                  scale: 1.0,
                  height: 150,
                ),
              ),
              Text(imageCaption),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _image = null;
                  });
                },
                child: Text('clear selection'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    imageCaption = 'uploading...';
                  });
                  uploadFile();
                },
                child: Text('upload image'),
              )
            ],
          )
        : Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    chooseFileFromGallery();
                  },
                  child: Text('Gallery'),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    chooseFileFromCamera();
                  },
                  child: Text('Camera'),
                ),
              ],
            ),
          );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: <Widget>[
            new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                    validator: (val) => val.isEmpty ? 'Name is required' : null,
                    onSaved: (String value) {
                      name = value;
                    },
                  ),
                  new Row(children: <Widget>[
                    new Expanded(
                        child: new TextFormField(
                            decoration: new InputDecoration(
                              icon: const Icon(Icons.calendar_today),
                              hintText: 'Enter your date of birth',
                              labelText: 'Dob',
                            ),
                            controller: _controller,
                            keyboardType: TextInputType.datetime,
                            validator: (val) =>
                                isValidDob(val) ? null : 'Not a valid date',
                            onSaved: (String value) {
                              dob = value;
                            })),
                    new IconButton(
                      icon: new Icon(Icons.more_horiz),
                      tooltip: 'Choose date',
                      onPressed: (() {
                        _chooseDate(context, _controller.text);
                      }),
                    )
                  ]),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => isValidNumber(value),
                    onSaved: (String value) {
                      phone = value;
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Address ',
                      labelText: 'address and home number',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Your address is required' : null,
                    onSaved: (String value) {
                      address = value;
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter N.I.N',
                      labelText: 'N.IN',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => isValidNumber(value),
                    onSaved: (String value) {
                      nim = value;
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => isValidEmail(value)
                        ? null
                        : 'Please enter a valid email address',
                    onSaved: (String value) {
                      email = value;
                    },
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.people_outline),
                          labelText: 'Gender',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _gender == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: _gender,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                // newContact.favoriteColor = newValue;
                                _gender = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _genders.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (val) {
                      return val != "" ? null : 'Please select a gender';
                    },
                    onSaved: (String value) {
                      gender = value;
                    },
                  ),
                  !kIsWeb
                      ? mobileUpload:
                      // : Container(
                      //     child: FlatButton(
                      //       onPressed: () async {
                      //         imageI = (await FlutterWebImagePicker.getImage)
                      //             as File;
                      //         setState(() {
                      //           _image = imageI;
                      //         });
                      //       },
                      //       child: Text('Pick Image'),
                      //     ),
                      //   ),
                  FlatButton(
                      onPressed: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=> WebUpload()));
                      },
                      child: Text('web upload')),
                  // Center(
                  //     child: _image != null
                  //         ? _image.toString()
                  //         : Text('No data...')),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _submitForm,
                      )),
                  _showCircularProgress(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  isValidNumber(String number) {
    if (number.length != 11) return "Enter a valid number";
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      _isLoading = true;
      form.save();
      DatabaseService(uid: widget.userId).updateUserData(name, dob, phone, nim,
          email, gender, isPolice, isRegistered, address, _uploadedFileURL);
      // _isLoading = false;
      print('submitq');

    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}
