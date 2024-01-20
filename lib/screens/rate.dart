import 'package:flutter/material.dart';

class RateUsPage extends StatefulWidget {
  @override
  _RateUsPageState createState() => _RateUsPageState();
}

class _RateUsPageState extends State<RateUsPage> {
  int _selectedStars = 0; 
  TextEditingController _commentController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Us',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  IconButton(
                    icon: Icon(
                      _selectedStars >= i ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedStars = i;
                      });
                    },
                  ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write something here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
            
              },
              child: Text('Done'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, 
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RateUsPage(),
  ));
}
