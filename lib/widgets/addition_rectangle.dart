import 'package:flutter/material.dart';

class AdditionRectangle extends StatelessWidget {
  final String text;
  final ImageProvider<Object> image;
  final ImageProvider<Object> secondImage;
  final Function onTap;

  const AdditionRectangle({
    Key? key,
    required this.text,
    required this.image,
    required this.onTap,
    required this.secondImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call the function when the box is tapped
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(8.0), // Reduced padding
        decoration: BoxDecoration(
          color: const Color(0xFFBEE3CB), // Set the color to #BEE3CB
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [ // Define the boxShadow property here
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Image(image: image, width: 40, height: 40), // Reduced image size
            const SizedBox(width: 8), // Reduced space between images and text
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Reduced font size
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ), // Display the text
            ),
            Image(image: secondImage, width: 60, height: 40), // Reduced image size
          ],
        ),
      ),
    );
  }
}
