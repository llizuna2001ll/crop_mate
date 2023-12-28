import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, color: Colors.black, size: 40.0,),
          SizedBox(width: 10.0),
          Text(
            'username',
            style: TextStyle(color: Colors.black, fontSize: 23.0),
          ),
        ],
      ),
    );
  }
}
