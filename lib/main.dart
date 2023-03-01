// import 'package:firebase_app/login_up.dart';
import 'package:firebase_app/email_verification.dart';
import 'package:firebase_app/home_page.dart';
import 'package:firebase_app/login_page.dart';
import 'package:firebase_app/sign_up.dart';
import 'package:firebase_app/suggestion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        // initialRoute: '/',
      home: LoginPage(),
    );
  }
}
