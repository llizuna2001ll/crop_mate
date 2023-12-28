import 'package:flutter/material.dart';

void main() {
  runApp(ResetPassword());
}

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
                title: const Text(''),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // You can customize this function
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  height: 199.09,
                  child: Image.asset(
                    "lib/assets/images/forgot.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Enter the email address you used when you joined and we\'ll send you instructions to reset your password.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'alimohamed@gmail.com',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.email),
                      onPressed: () {
                        // TODO: Your email suffix icon logic
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Reset password functionality here
                  },
                  child: const Text(
                    'Send Link',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, ).copyWith(
                  fixedSize: MaterialStateProperty.all(const Size(400, 30)),
                ),
                ),

                  const SizedBox(height: 50),
        Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text("Having a Problem?"),
    TextButton(
      onPressed: () {
// Navigator.pushNamed(context, '/signup');
      },
      child: const Text(
        'Send Again',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.green,
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
