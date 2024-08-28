import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notetextcontent extends StatelessWidget {
  final String notecontent;
  const notetextcontent({
    required this.notecontent,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        title: Text(
          "Content",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text(
            notecontent,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ));
  }
}
