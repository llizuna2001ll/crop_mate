import 'package:flutter/material.dart';
import 'package:cropmate/screens/chat_bot.dart';
import 'package:cropmate/screens/lands.dart';
import 'package:cropmate/screens/soil_status.dart';
import 'package:cropmate/widgets/addition_rectangle.dart';
import 'package:cropmate/widgets/features_container.dart';
import 'package:cropmate/widgets/home_header.dart';
import 'package:cropmate/widgets/navbar.dart';
import 'package:cropmate/widgets/weather.dart';
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
      bottomNavigationBar: const Navbar(selectedIndex: 0,),
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
                  text: 'Lands',
                  image: const AssetImage("lib/assets/images/add_crop.png"),
                  secondImage: const AssetImage("lib/assets/images/next_icon.png"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            Lands(token: widget.token),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
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
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FeaturesContainer(
                          imagePath: 'lib/assets/images/diagnose_icon.png',
                          text: 'Diagnose your crop',
                          bottomText: 'Diagnose',
                          onTap: () {
                            print("go to diagnose");
                          },
                        ),
                        FeaturesContainer(
                          imagePath: 'lib/assets/images/status_icon.png',
                          text: 'Follow your soil status',
                          bottomText: 'Soil Status',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) =>
                                    SoilStatus(token: widget.token),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
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
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => ChatBot(token: widget.token),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeOutCubic;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        FeaturesContainer(
                          imagePath: 'lib/assets/images/scan_icon.png',
                          text: 'scan_icon',
                          bottomText: 'Scan Crop',
                          onTap: () {
                            print("go to scan");
                          },
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
