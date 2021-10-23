// ignore_for_file: file_names, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: implementation_imports

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToSignupScreen() {
    Navigator.pushReplacementNamed(context, "/SignupPage");
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  void signin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email!, password: _password!);
      } catch (e) {
        showError(e.toString());
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
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
                          onSaved: (input) => _password = input!,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: RaisedButton(
                          padding:
                              EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: signin,
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      //Redirect to sign up pagr
                      GestureDetector(
                        onTap: navigateToSignupScreen,
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
