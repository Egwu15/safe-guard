
import 'package:flutter/material.dart';
import 'screens/root_page.dart';
import './services/authentication.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Guard',
      home: new RootPage(auth: new Auth())
      );
  }
  
}