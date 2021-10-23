// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignupPage.dart';
import 'SigninPage.dart';
import 'dart:html';

void main() => runApp(MyApp());

// if app did not work see define rauter in main vedio again

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireBase login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "/SigninPage": (BuildContext context) => SigninPage(),
        "/SignupPage": (BuildContext context) => SignupPage(),
      },
    );
  }
}
