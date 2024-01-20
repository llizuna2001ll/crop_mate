import 'package:flutter/material.dart';
import 'package:cropmate/screens/CropPage.dart';
import 'package:cropmate/screens/chat_bot.dart';
import 'package:cropmate/screens/crops.dart';
import 'package:cropmate/screens/lands.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home.dart';

class Navbar extends StatefulWidget {
  final int selectedIndex;

  const Navbar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: Container(
          color: const Color(0xFFFAFAFA),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              backgroundColor: const Color(0xFFFAFAFA),
              color: const Color(0xFF4BA26A),
              activeColor: const Color(0xFF4BA26A),
              tabBackgroundColor: const Color(0xFFBEE3CB),
              gap: 15,
              padding: const EdgeInsets.all(16),
              selectedIndex: widget.selectedIndex,
              tabs: const [
                GButton(
                  icon: FontAwesomeIcons.house,
                  text: 'Home',
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4BA26A)),
                  iconSize: 28,
                ),
                GButton(
                  icon: FontAwesomeIcons.wheatAwn,
                  text: 'Crops',
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4BA26A)),
                  iconSize: 28,
                ),
                GButton(
                  icon: Icons.message,
                  text: 'Boba Chatbot',
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4BA26A)),
                  iconSize: 28,
                ),
                GButton(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4BA26A)),
                  iconSize: 28,
                ),
              ],
              onTabChange: (index) {
                if (index == 0) {
                  {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            Home(token: sharedPreferences.getString('token')),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  }
                } else if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ChatBot(token: sharedPreferences.getString('token')),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
                else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          Crops(token: sharedPreferences.getString('token')),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
