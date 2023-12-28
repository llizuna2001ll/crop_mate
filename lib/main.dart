import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/first_step.dart';
import 'package:flutter_projects/screens/home.dart';
import 'package:flutter_projects/screens/reset_password.dart';
import 'package:flutter_projects/screens/second_step.dart';
import 'package:flutter_projects/screens/sign_in.dart';
import 'package:flutter_projects/screens/sign_up.dart';
import 'package:flutter_projects/screens/third_step.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PT_Sans'),
      initialRoute: '/first_step',
      routes: {
        '/first_step': (context) => const FirstStep(),
        '/second_step': (context) => const SecondStep(),
        '/third_step': (context) => const ThirdStep(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/reset_password': (context) => ResetPassword(),
        '/home': (context) => const Home(),
      },
    );
  }
}
