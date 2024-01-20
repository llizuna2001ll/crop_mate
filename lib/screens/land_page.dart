import 'package:flutter/material.dart';
import 'package:cropmate/screens/lands.dart';
import '../models/land_model.dart';
import '../services/land_api_service.dart';
import '../services/recommendation_api_service.dart'; // Make sure to import the RecommendationApiService
import '../models/recommendation_response.dart';

import '../widgets/navbar.dart';
import 'home.dart';

class LandPage extends StatefulWidget {
  final token;
  final landId;
  final image;

  const LandPage(
      {Key? key,
      @required this.token,
      @required this.landId,
      @required this.image})
      : super(key: key);

  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  String landImage = '';
  String currentSection = 'Land Info';
  final LandApiService _apiService = LandApiService();
  final RecommendationApiService _recommendationApiService =
      RecommendationApiService();
  late Future<Land> _land;
  late Future<List<RecommendationResponse>> _recommendations;

  @override
  void initState() {
    super.initState();
    _land = _apiService.getLandById(widget.token, widget.landId);
    _recommendations = _recommendationApiService.getAllRecommendationsByLandId(
        widget.token, widget.landId);

  }

  @override
  Widget build(BuildContext context) {
    landImage = widget.image;
    return Scaffold(
      bottomNavigationBar: const Navbar(
        selectedIndex: 1,
      ),
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
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Lands(token: widget.token),
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
        title: FutureBuilder<Land>(
          future: _land,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            }

            return Text(
              snapshot.data!.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'PT_Sans',
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Land>(
          future: _land,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            Land land = snapshot.data!;

            return Column(
              children: [
                Container(
                  width: 330,
                  height: 148.60,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(landImage),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Applied border radius to all corners
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentSection = 'Land Info';
                        });
                      },
                      child: Text(
                        'Land Info',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: currentSection == 'Land Info'
                              ? Colors.green
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PT_Sans',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentSection = 'Boba Recommendations';
                        });
                      },
                      child: Text(
                        'Boba Recommendations',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: currentSection == 'Boba Recommendations'
                              ? Colors.green
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PT_Sans',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Visibility(
                  visible: currentSection == 'Land Info',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color(0xFF4BA26A),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Soil Type',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    land.soilType.toString().split('.').last,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color(0xFF4BA26A),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Nitrogen',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    land.nitrogen.toString().split('.').last,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: currentSection == 'Land Info',
                    child: const SizedBox(height: 16.0)),
                Visibility(
                  visible: currentSection == 'Land Info',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color(0xFF4BA26A),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Phosphorus',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    land.phosphorus.toString().split('.').last,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color(0xFF4BA26A),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Potassium',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    land.potassium.toString().split('.').last,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: currentSection == 'Land Info',
                    child: const SizedBox(height: 16.0)),
                Visibility(
                  visible: currentSection == 'Land Info',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color(0xFF4BA26A),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Region',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    land.region,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color(0xFF4BA26A),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Moisture',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    land.moistureLevel
                                        .toString()
                                        .split('.')
                                        .last,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: currentSection == 'Land Info',
                    child: const SizedBox(height: 16.0)),
                Visibility(
                  visible: currentSection == 'Land Info',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color(0xFF4BA26A),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Temperature',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    land.temperature.toString(),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PT_Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (currentSection == 'Boba Recommendations') ...[
                  const SizedBox(height: 16.0),
                  Visibility(
                    visible: currentSection == 'Boba Recommendations',
                    child: FutureBuilder<List<RecommendationResponse>>(
                      future: _recommendations,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No recommendations available'));
                        }

                        // Display Recommendations in an Accordion
                        return Column(
                          children: [
                            // Other widgets
                            Container(
                              height: 400, // Adjust the height accordingly
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  RecommendationResponse recommendation = snapshot.data![index];

                                  bool isTileExpanded = false; // Track the expansion state for each tile
                                  Color color = Colors.black;
                                  return ExpansionTile(
                                    onExpansionChanged: (isExpanded) {
                                      setState(() {
                                        color = isExpanded ? const Color(0xFF4BA26A) : Colors.black;
                                      });
                                    },
                                    title: Text(
                                      recommendation.cropName ?? 'N/A',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'PT_Sans',
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          recommendation.reasonWhy ?? 'No reason provided',
                                          style: const TextStyle(fontFamily: 'PT_Sans'),
                                        ),
                                      ),
                                      // Additional details or actions can be added here
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
