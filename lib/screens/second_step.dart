import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SecondStep extends StatelessWidget {
  const SecondStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Image.asset(
                'lib/assets/images/man_tree.png',
                width: 300,
                height: 400, // Set the width of the image
                fit: BoxFit.contain,
              ),
            ),
            // Your image here
            const SizedBox(height: 20),
            // Add some space between the image and text
            const Padding(
              padding:
              EdgeInsets.only(bottom: 10.0, left: 50.0, right: 50.0),
              child: Text(
                'Early detection of plant and soil diseases',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Add space between title and paragraph
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 20.0, bottom: 70.0),
              child: Text(
                'our project can detect plant and soil diseases using an existing camera sensor that tracks the plants in real-time day by day.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF9C9C9C)),
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 130.0, right: 130.0),
                  child: StepProgressIndicator(
                    totalSteps: 3,
                    currentStep: 2,
                    selectedColor: Color(0xFF4BA26A),
                    unselectedColor: Color(0xFFF3F3F3),
                    roundedEdges: Radius.circular(20),
                    size: 10.0,
                    padding: 5.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFD6D6D6)),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(
                                180, 40)), // Adjust width and height here
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/first_step');
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          // Set the font weight to bold
                          fontSize:
                          16, // Optional: Adjust font size if needed
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF4BA26A)),
                        // Change the background color here
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(
                                180, 40)), // Adjust width and height here
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/third_step');
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // Set the font weight to bold
                          fontSize:
                          16, // Optional: Adjust font size if needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}