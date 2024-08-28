import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteapp/components/textfields.dart';
import 'package:noteapp/functions/authfunction.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  bool islogin = false;
  final _formkey = GlobalKey<FormState>();
  String username = "";
  String email = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Center(
              child: Text(
            "Register Now",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                islogin
                    ? Container()
                    : Card(
                        child: TextFormField(
                          key: ValueKey("username"),
                          decoration:
                              InputDecoration(hintText: "Enter Username"),
                          validator: (value) {
                            if (value.toString().length < 7) {
                              return "Too Short Username";
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              {
                                username = value!;
                              }
                            });
                          },
                        ),
                      ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: TextFormField(
                    key: ValueKey("email"),
                    decoration: InputDecoration(hintText: "Enter email"),
                    validator: (value) {
                      if (value.toString().length < 7 &&
                          !value.toString().contains('@')) {
                        return "Invalid email";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        {
                          email = value!;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: TextFormField(
                    key: ValueKey("pass"),
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Enter Password"),
                    validator: (value) {
                      if (value.toString().length < 7) {
                        return "Too Short Password";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        {
                          pass = value!;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate())
                            _formkey.currentState!.save();
                          islogin ? signin(email, pass) : signup(email, pass);
                        },
                        child: islogin ? Text("Log in") : Text("Sigh Up"))),
                TextButton(
                    onPressed: () {
                      setState(() {
                        islogin = !islogin;
                      });
                    },
                    child: islogin
                        ? Text("Sign Up")
                        : Text("Already Registered? Log in"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
