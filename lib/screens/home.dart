import 'package:flutter/material.dart';
import 'package:flutter_projects/widgets/home_header.dart';
import 'package:flutter_projects/widgets/weather.dart';
import 'package:flutter_projects/widgets/navigation_bar.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  void _handleItemTap(int index) {
    print("issam");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: HomeHeader(),
            ),
            Weather(),
          ],
        ),
      ),
    );
  }
}
