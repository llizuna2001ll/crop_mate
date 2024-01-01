import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/chat_bot.dart';
import 'package:flutter_projects/screens/first_step.dart';
import 'package:flutter_projects/screens/home.dart';
import 'package:flutter_projects/screens/reset_password.dart';
import 'package:flutter_projects/screens/second_step.dart';
import 'package:flutter_projects/screens/sign_in.dart';
import 'package:flutter_projects/screens/sign_up.dart';
import 'package:flutter_projects/screens/third_step.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');

  bool isLoggedIn = false;
  if (token != null) {
    isLoggedIn = !JwtDecoder.isExpired(token);
  }

  runApp(MyApp(isLoggedIn: isLoggedIn, token: token));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? token;

  const MyApp({Key? key, required this.isLoggedIn, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PT_Sans'),
      // initialRoute: isLoggedIn ? '/home' : '/signing',
      initialRoute: '/home',
      routes: {
        '/first_step': (context) => const FirstStep(),
        '/second_step': (context) => const SecondStep(),
        '/third_step': (context) => const ThirdStep(),
        '/signing': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/reset_password': (context) => ResetPassword(),
        '/chatbot': (context) => const ChatBot(),
        '/home': (context) => Home(token: token),
      },
    );
  }
}
