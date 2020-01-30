import 'package:flutter/material.dart';

class SideBarList extends StatelessWidget {
  SideBarList({this.textTitle, this.onPress, this.iconWidget});
  final String textTitle;
  final Function onPress;
  final Widget iconWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconWidget,
      title: Text(
        textTitle,
        style: TextStyle(color: Colors.lightGreen[800]),
      ),
      onTap: onPress,
    );
  }
}
