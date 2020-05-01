import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safeguard/screens/Your_account.dart';
import 'package:safeguard/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:intl/intl.dart';

// void main() => runApp(new MyApp());

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage({Key key, this.userId}) : super(key: key);

  final userId;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(
        title: 'Details',
        userId: userId,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MyHomePage({
    Key key,
    this.title,
    this.userId,
  }) : super(key: key);
  final String title;
  final userId;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({
    Key key,
    this.title,
    this.userId,
  });
  final String title;
  final  userId;

  String name;
  String dob;
  String phone;
  String nim;
  String email;
  String gender;

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

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: Stack(children: <Widget>[
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
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _submitForm,
                      )),
               _showCircularProgress(), ],
              ),
            ),
            
          ])),
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
      DatabaseService(uid: widget.userId)
          .updateUserData(name, dob, phone, nim, email, gender);
          // _isLoading = false;
          print(widget.userId);
          print('spad');
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}
