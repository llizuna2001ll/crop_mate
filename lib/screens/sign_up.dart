import 'package:flutter/material.dart';
import '../services/user_api_service.dart';
import '../widgets/social_button_rect.dart';

void main() {
  runApp(SignUp());
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final UserApiService _apiService = UserApiService();

  String username = '';
  String password = '';
  String email = '';
  String city = '';
  String contactNumber = '';
  String response = '';

  void _signUpUser(String username, String password, String email,
      String city, String contactNumber) async {
    final result = await _apiService.signUpUser(
        username, password, email, city, contactNumber);
    setState(() {
      if (result['success']) {
        response = 'Signed Up successfully';
        print(response);
      } else {
        response = '${result['error']}';
        print(response);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Create your account in few steps',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF9C9C9C),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.account_box_outlined),
                  ),
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                ),
                const SizedBox(height: 8.0),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 8.0),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_android),
                  ),
                  onChanged: (value) {
                    setState(() {
                      contactNumber = value;
                    });
                  },
                ),
                const SizedBox(height: 8.0),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'City/Region',
                    prefixIcon: Icon(Icons.house_outlined),
                  ),
                  onChanged: (value) {
                    setState(() {
                      city = value;
                    });
                  },
                ),
                const SizedBox(height: 8.0),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 30.0),
                Text(
                  response,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    _signUpUser(
                        username, password, email, city, contactNumber);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF62A06F),
                    padding: const EdgeInsets.all(15.0),
                  ).copyWith(
                    fixedSize: MaterialStateProperty.all(const Size(400, 50)),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 1,
                      width: 100,
                      color: const Color(0xFF9C9C9C),
                    ),
                    const Text(
                      'or sign up with',
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
                const SizedBox(height: 20.0),
                Row(
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
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You have an account already?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: const Text(
                        'Sign In',
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
      ),
    );
  }
}
