import 'package:flutter/material.dart';

class BasicInformationPage extends StatefulWidget {
  @override
  _BasicInformationState createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformationPage> {
  final String basicInformation = '基本情報';
  TextStyle menuItemStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Text(basicInformation),
      color: Colors.red,
    );
  }
}