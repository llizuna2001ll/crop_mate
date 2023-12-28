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
      title: 'Log In Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Create your account in few steps',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF9C9C9C)),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_box_outlined),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // Assuming this code is inside a Stateful widget
                        username = value;
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  onChanged: (value) {
                    setState(() {
                      // Assuming this code is inside a Stateful widget
                      email = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_android),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // Assuming this code is inside a Stateful widget
                        contactNumber = value;
                      });
                    }),
              ),
               Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'City/Region',
                    prefixIcon: Icon(Icons.house_outlined),
                  ),
                  onChanged: (value) {
                    setState(() { // Assuming this code is inside a Stateful widget
                      city = value;
                    });
                  }
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  onChanged: (value) {
                    setState(() { // Assuming this code is inside a Stateful widget
                      password = value;
                    });
                  },
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  response,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      _signUpUser(
                          username, password, email, city, contactNumber);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF62A06F),
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
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You have an account already?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
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
