import 'package:flutter/material.dart';
import 'package:flutter_projects/widgets/addition_rectangle.dart';
import 'package:flutter_projects/widgets/features_container.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: HomeHeader(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Weather(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AdditionRectangle(
                  text: 'Crops',
                  image: const AssetImage("lib/assets/images/add_crop.png"),
                  secondImage: const AssetImage("lib/assets/images/next_icon.png"),
                  onTap: () {
                    print('Go to add crop');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AdditionRectangle(
                  text: 'Sensors',
                  image: const AssetImage("lib/assets/images/add_sensor.png"),
                  secondImage: const AssetImage("lib/assets/images/next_icon.png"),
                  onTap: () {
                    print('Go to add sensor');
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FeaturesContainer(
                          imagePath: 'lib/assets/images/diagnose_icon.png',
                          text: 'Diagnose your crop',
                          bottomText: 'Diagnose Disease',
                        ),
                        FeaturesContainer(
                          imagePath: 'lib/assets/images/add_sensor.png',
                          text: 'Follow your soil status',
                          bottomText: 'Soil Status',
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Adding space between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FeaturesContainer(
                          imagePath: 'lib/assets/images/chat_icon.png',
                          text: 'Ask for anything you want',
                          bottomText: 'Consult your AI',
                        ),
                        FeaturesContainer(
                          imagePath: 'lib/assets/images/scan_icon.png',
                          text: 'scan_icon',
                          bottomText: 'Scan Crop',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
