import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/second_step.dart';
import 'package:flutter_projects/screens/sign_in.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ThirdStep extends StatelessWidget {
  const ThirdStep({super.key});

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
                'lib/assets/images/man_sondage.png',
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
                'Improve agriculture precision',
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
              padding: EdgeInsets.only(left: 10.0, right: 20.0, bottom: 50.0),
              child: Text(
                'we will use satellite imagery, image processing, deep learning, computer vision, and remote sensing to detect changes in the field and crops and solve the problems whenever they pop.',
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
                    currentStep: 3,
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
                        minimumSize: MaterialStateProperty.all<Size>(const Size(
                            180, 40)), // Adjust width and height here
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
                        'Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // Set the font weight to bold
                          fontSize: 16, // Optional: Adjust font size if needed
                          color: Colors.black,
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
                        minimumSize: MaterialStateProperty.all<Size>(const Size(
                            180, 40)), // Adjust width and height here
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 500), // Set your desired duration
                            pageBuilder: (context, animation1, animation2) {
                              return FadeTransition(
                                opacity: animation1,
                                child: SignIn(),
                              );
                            },
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
