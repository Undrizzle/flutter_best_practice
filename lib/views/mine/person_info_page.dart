import 'package:flutter/material.dart';

class PersonInfoPage extends StatefulWidget {
  final String mOtherUserId;

  PersonInfoPage(this.mOtherUserId);

  @override 
  _PersonInfoPageState createState() => _PersonInfoPageState();
}

class _PersonInfoPageState extends State<PersonInfoPage> with SingleTickerProviderStateMixin {
  @override 
  Widget build(BuildContext context) {
    return Text('个人信息页');
  }
}