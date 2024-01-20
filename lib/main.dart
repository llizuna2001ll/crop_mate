import 'package:flutter/material.dart';
import 'package:cropmate/screens/chat_bot.dart';
import 'package:cropmate/screens/crops.dart';
import 'package:cropmate/screens/first_step.dart';
import 'package:cropmate/screens/home.dart';
import 'package:cropmate/screens/land_page.dart';
import 'package:cropmate/screens/lands.dart';
import 'package:cropmate/screens/reset_password.dart';
import 'package:cropmate/screens/second_step.dart';
import 'package:cropmate/screens/sign_in.dart';
import 'package:cropmate/screens/sign_up.dart';
import 'package:cropmate/screens/soil_status.dart';
import 'package:cropmate/screens/third_step.dart';
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
      initialRoute: isLoggedIn ? '/home' : '/signing',
      routes: {
        '/first_step': (context) => const FirstStep(),
        '/second_step': (context) => const SecondStep(),
        '/third_step': (context) => const ThirdStep(),
        '/signing': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/reset_password': (context) => ResetPassword(),
        '/chatbot': (context) => const ChatBot(),
        '/home': (context) => Home(token: token),
        '/lands': (context) => const Lands(),
        '/landPage': (context) => LandPage(token: token),
        '/crops': (context) => Crops(token: token),
        '/soil_status': (context) => SoilStatus(token: token),
      },
    );
  }
}
