import 'package:flutter/material.dart';
import 'package:flutter_projects/widgets/addition_rectangle.dart';
import 'package:flutter_projects/widgets/features_container.dart';
import 'package:flutter_projects/widgets/home_header.dart';
import 'package:flutter_projects/widgets/weather.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  final token;

  const Home({Key? key, @required this.token}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String username;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    username = jwtDecodedToken['sub'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
               Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: HomeHeader(username: username),
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
                          imagePath: 'lib/assets/images/status_icon.png',
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
