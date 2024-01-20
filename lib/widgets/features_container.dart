import 'package:flutter/material.dart';

class FeaturesContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  final String bottomText;
  final Function onTap;

  const FeaturesContainer({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.bottomText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: const Color(0xFFBEE3CB),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF4BA26A),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5), // Add spacing between text and bottom section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
            child: GestureDetector(
              onTap: () {
                onTap();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF4BA26A),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bottomText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5), // Add spacing between image and text
                    Image.asset(
                      "lib/assets/images/next_icon.png",
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
