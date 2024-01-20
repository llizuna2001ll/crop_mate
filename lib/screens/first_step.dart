import 'package:flutter/material.dart';
import 'package:cropmate/screens/second_step.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class FirstStep extends StatelessWidget {
  const FirstStep({super.key});

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
                'lib/assets/images/man_phone.png',
                width: 300,
                height: 400, // Set the width of the image
                fit: BoxFit.contain,
              ),
            ),
            // Your image here
            const SizedBox(height: 20),
            // Add some space between the image and text
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0, left: 100.0, right: 100.0),
              child: Text(
                'Monitoring soil and plant',
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
              padding: EdgeInsets.only(left: 10.0, right: 20.0, bottom: 93.0),
              child: Text(
                'we aim to use optical (VIR) sensing to observe the fields and make timely crop management decisions.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF9C9C9C)),
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 130.0),
                  child: StepProgressIndicator(
                    totalSteps: 3,
                    currentStep: 1,
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(const Size(
                            180, 40)), // Adjust width and height here
                      ),
                      onPressed: null,
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // Set the font weight to bold
                          fontSize: 16, // Optional: Adjust font size if needed
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF4BA26A)),
                        // Change the background color here
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(180, 40)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const SecondStep(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // Set the font weight to bold
                          fontSize: 16, // Optional: Adjust font size if needed
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
