import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../widgets/navbar.dart';
import 'home.dart';

class SoilStatus extends StatefulWidget {
  final token;

  const SoilStatus({Key? key, @required this.token}) : super(key: key);

  @override
  _SoilStatusState createState() => _SoilStatusState();
}

class _SoilStatusState extends State<SoilStatus> {
  String _status = 'Normal';
  static const _colors = [
    Color(0x6B4DABE9),
    Color(0xFF4DABE9),
  ];

  static const _backgroundColor = Color(0x77F8F8F8);

  static const _durations = [
    5000,
    4000,
  ];

  static const _heightPercentages = [
    0.21,
    0.20,
  ];

  void _changeStatus() {
    setState(() {
      if (_status == 'Normal') {
        _status = 'Dry';
      } else {
        _status = 'Normal';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Navbar(selectedIndex: 0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Home(token: widget.token),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeOutCubic;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        title: const Text(
          'Soil Status',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'PT_Sans',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 287,
              height: 287,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFE1E1E1),
                  ),
                  borderRadius: BorderRadius.circular(260),
                ),
              ),
              child: WaveWidget(
                config: CustomConfig(
                  colors: _colors,
                  durations: _durations,
                  heightPercentages: _heightPercentages,
                ),
                backgroundColor: _backgroundColor,
                size: Size(double.infinity, double.infinity),
                waveAmplitude: 0,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Moisture Level: 80%',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'PT_Sans',
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
