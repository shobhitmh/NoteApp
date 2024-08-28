import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteapp/database/databasefunctions.dart';

class makenotepage extends StatefulWidget {
  const makenotepage({super.key});

  @override
  State<makenotepage> createState() => _makenotepageState();
}

class _makenotepageState extends State<makenotepage> {
  final TextEditingController _noteController =
      TextEditingController(); // Controller to manage text input
  @override
  void dispose() {
    _noteController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text(
          'Make Note',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _noteController,
                maxLines: null, // Allows for multiline input
                expands: true, // Makes TextField fill the available space
                textAlignVertical:
                    TextAlignVertical.top, // Aligns text to the top
                decoration: InputDecoration(
                  hintText: 'Write your note here...',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                create(_noteController.text);
                Navigator.pop(context);
              }, // Calls _saveNote method
              child: Text('Save Note'),
            ),
          ),
        ],
      ),
    );
  }
}
