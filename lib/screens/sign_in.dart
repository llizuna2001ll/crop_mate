import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/home.dart';
import 'package:flutter_projects/services/user_api_service.dart';
import 'package:flutter_projects/widgets/social_button_rect.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final UserApiService _apiService = UserApiService();
  final storage = const FlutterSecureStorage();
  late SharedPreferences sharedPreferences;

  String username = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void _loginUser(String username, String password) async {
    final result = await _apiService.loginUser(username, password);
    if (result['success']) {
      print('Login Successful!');
      Map<String, dynamic> response = result['data'];
      sharedPreferences.setString('token', response['token']);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(token: response['token'])));
    } else {
      print('Login Failed: ${result['error']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                width: 220,
                height: 200,
                child: Image.asset(
                  "lib/assets/images/login.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Please sign in to continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF9C9C9C),
                ),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(FontAwesomeIcons.user),
                ),
                onChanged: (value) {
                  username = value;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                cursorColor: Colors.green,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
              ),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implement Forgot Password action
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4BA26A),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  _loginUser(username, password);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF62A06F),
                  padding: const EdgeInsets.all(15.0),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Divider(
                      height: 1,
                      color: Color(0xFF9C9C9C),
                    ),
                  ),
                  Text(
                    'or sign in with',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9C9C9C),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1,
                      color: Color(0xFF9C9C9C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButtonRect.socialButtonCircle(
                    "lib/assets/images/facebook.png",
                    iconColor: Colors.white,
                    onTap: () {
                      // TODO: Implement Facebook sign-in
                    },
                  ),
                  SocialButtonRect.socialButtonCircle(
                    "lib/assets/images/google.png",
                    iconColor: Colors.white,
                    onTap: () {
                      // TODO: Implement Google sign-in
                    },
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'sign up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF62A06F),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
