import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteapp/database/databasefunctions.dart';
import 'package:noteapp/pages/makenote.dart';
import 'package:noteapp/pages/notecontent.dart';

class homescreen extends StatefulWidget {
  homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  User? user; // Declare a user object

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Call fetchUserData to get user information
  }

  void fetchUserData() {
    // Get the current user
    user = FirebaseAuth.instance.currentUser;

    // Use setState to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[200],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Icon(
                Icons.note,
                size: 160,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            user != null
                ? Text(
                    'Email: ${user!.email ?? 'No display name set'}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                : Text(''),
            SizedBox(
              height: 90,
            ),
            ListTile(
              onTap: () {
                homescreen();
                Navigator.pop(context);
              },
              leading: Icon(Icons.home),
              trailing: Icon(Icons.arrow_right),
              title: Text(
                'Home',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => makenotepage()));
              },
              leading: Icon(Icons.edit),
              trailing: Icon(Icons.arrow_right),
              title: Text(
                'Make Notes',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () => FirebaseAuth.instance.signOut(),
              leading: Icon(Icons.logout),
              title: Text(
                'Signout',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "NoteApp",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[400],
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Usernotes').snapshots(),
        builder: (context, notesnapshot) {
          if (notesnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            final notedock = notesnapshot.data!.docs;
            return ListView.builder(
                itemCount: notedock.length,
                itemBuilder: (context, index) {
                  final noteid = notedock[index].id;
                  String notetext = notedock[index]['Notes'];
                  String displaytext = "";
                  for (int i = 0; i < notetext.length % 10; i++) {
                    displaytext += notetext[i];
                  }
                  return Wrap(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => notetextcontent(
                                              notecontent: notetext,
                                            ))),
                                child: SizedBox(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        notetext.length < 30
                                            ? Text(
                                                "  " + notetext,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                "   " + displaytext + "....",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    delete('Usernotes', noteid);
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    _showInputDialogUpdate(
                                                        context, noteid);
                                                  },
                                                  child: Icon(Icons.edit))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                    ],
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInputDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showInputDialog(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Your Note'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Type something here..."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                create(_textFieldController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInputDialogUpdate(BuildContext context, String noteId) {
    TextEditingController _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update your Note'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Type something here..."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                updat(noteId, 'Notes', _textFieldController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
