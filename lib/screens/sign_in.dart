import 'package:flutter/material.dart';
import 'package:flutter_projects/services/user_api_service.dart';
import 'package:flutter_projects/widgets/social_button_rect.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SignIn extends StatelessWidget {
  final UserApiService _apiService = UserApiService();
  final storage = const FlutterSecureStorage();

  void _loginUser(String username, String password) async {
    final result = await _apiService.loginUser(username, password);
    if (result['success']) {
      print('Login Successful!');
      Map<String, dynamic> response = result['data'];
      await storage.write(key: 'jwt', value: response['token']);
      String? jwt = await storage.read(key: 'jwt');
      print('jwt from storage:  $jwt');
    }
    else {
      print('Login Failed: ${result['error']}');
    }
  }

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: 220,
                height: 200,
                child: Image.asset(
                  "lib/assets/images/login.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const Text(
              'Please sign in to continue',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF9C9C9C)),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(FontAwesomeIcons.user),
              ),
              onChanged: (value) {
                username = value!;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
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
            ),
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4BA26A),
              ),
              textAlign: TextAlign.end,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  onPressed: () {
                    _loginUser(username,password);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF62A06F),
                  ).copyWith(
                    fixedSize: MaterialStateProperty.all(const Size(400, 50)),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 1,
                    width: 100,
                    color: const Color(0xFF9C9C9C),
                  ),
                  const Text(
                    'or sign in with',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9C9C9C),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 100,
                    color: const Color(0xFF9C9C9C),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButtonRect.socialButtonCircle(
                    "lib/assets/images/facebook.png",
                    iconColor: Colors.white,
                    onTap: () {
                      // TODO
                    },
                  ),
                  SocialButtonRect.socialButtonCircle(
                    "lib/assets/images/google.png",
                    iconColor: Colors.white,
                    onTap: () {
                      // TODO
                    },
                  ),
                ],
              ),
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
    );
  }
}
