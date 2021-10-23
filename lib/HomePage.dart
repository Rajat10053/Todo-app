// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser? user;

  bool isSignedIn = false;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SigninPage");
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser!;
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser!;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        // ignore: unnecessary_this
        this.isSignedIn = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: !isSignedIn
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(50),
                        child: Image(
                          image: AssetImage("assets/logo.png"),
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(50),
                        child: Text(
                          "Hello, ${user!.displayName}, Ypur are Logged in as ${user!.email}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: RaisedButton(
                          color: Colors.blue,
                          padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: signOut,
                          child: Text(
                            "Signout",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )),
      ),
    );
  }
}
