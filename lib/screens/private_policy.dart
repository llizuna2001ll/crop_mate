import 'package:flutter/material.dart';

void main() {
  runApp(PrivatePolicyApp());
}

class PrivatePolicyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Privacy Policy',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PrivatePolicyPage(),
    );
  }
}

class PrivatePolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.security,
              color: Colors.white,
            ),
            onPressed: () {
            },
          ),
        ],
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'We\'re on a mission to make renting the new black, by providing seamless comfort with affordable pricing.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'With us, you can rent a wide range of well-conditioned vehicles, like, SUVs, MUVs, sedans, vintage cars and chariots at very affordable prices.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.center,
              child: Text(
                '© Copyright Crobit team',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
