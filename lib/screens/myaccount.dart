import 'package:flutter/material.dart';

void main() {
  runApp(MyAccountApp());
}

class MyAccountApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Account',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyAccountPage(),
    );
  }
}

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account',
      style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            // dir page li 9bal
          },
        ),
        
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.8, 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
              backgroundImage: AssetImage('lib/assets/images/avatar.png'),
             
              ),
               SizedBox(height: 10), 
              Text(
                'Change Picture',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              InfoWidget(title: 'Username', value: 'Errajraji Imane'),
              SizedBox(height: 16),
              InfoWidget(title: 'Email', value: 'imaneerrj@gmail.com'),
              SizedBox(height: 16),
              InfoWidget(title: 'Phone Number', value: '+212668349565'),
              SizedBox(height: 16),
               InfoWidget(title: 'Password', value: 'hwjdkod34'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                },
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title;
  final String value;

  const InfoWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
