import 'package:flutter/material.dart';

void main() {
  runApp(AboutUsApp());
}

class AboutUsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About us ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
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
          'About us',
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
  'This Platform Can Let The User Recognize The Regarding Nearest Location Wherever They\'ll Park Their Vehicles, It\'ll Let The User Comprehend Their Favorite Fuel Station And Their Name, Eventually It\'ll Let The User Comprehend The Place From Wherever They\'ll Get Their Flat Tyres Repaired...',
  style: TextStyle(
    fontSize: 17,
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
