import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String username;

  const HomeHeader({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              "lib/assets/images/user_icon.png",
              width: 30,
              height: 30,
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            username,
            style: const TextStyle(color: Colors.black, fontSize: 23.0),
          ),
        ],
      ),
    );
  }
}
