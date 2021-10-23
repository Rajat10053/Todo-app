// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name, _email, _Password;

  CheckAuthetication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToSigninScreen() {
    Navigator.pushReplacementNamed(context, "/SigninPage");
  }

  @override
  void initState() {
    super.initState();
    this.CheckAuthetication();
  }

  showError(String errorMassage) {
    errorMassage = Text("There is error man") as String;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // ignore: prefer_const_constructors
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMassage),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        FirebaseUser user = await _auth.createUserWithEmailAndPassword(
            email: _email!, password: _Password!);
        if (user != null) {
          UserUpdateInfo updateuser = UserUpdateInfo();
          updateuser.displayName = _name;
          user.updateProfile(updateuser);
        }
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              //email
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                // ignore: prefer_const_constructors
                child: Image(
                  image: AssetImage("assets/logo.png"),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(60.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'Provide an Name';
                            }
                          },
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                          onSaved: (input) => _name = input!,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'Provide an Email';
                            }
                          },
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                          onSaved: (input) => _email = input!,
                        ),
                      ),
                      //password
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: TextFormField(
                          validator: (input) {
                            if (input!.length < 6) {
                              return 'Password should be 6 char atlest';
                            }
                          },
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                          onSaved: (input) => _Password = input!,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: RaisedButton(
                          padding:
                              EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: signUp,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      //Redirect to sign up pagr
                      GestureDetector(
                        onTap: navigateToSigninScreen,
                        child: Text(
                          'Create an account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
