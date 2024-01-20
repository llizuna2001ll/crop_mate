import 'package:flutter/material.dart';
import 'package:cropmate/models/land_model.dart'; // Assuming you have a Land model class
import 'package:cropmate/screens/home.dart';
import 'package:cropmate/services/land_api_service.dart'; // Assuming you have a LandApiService class
import 'package:jwt_decoder/jwt_decoder.dart';

import '../widgets/add_land_modal.dart';
import '../widgets/navbar.dart';
import 'land_page.dart';

void main() {
  runApp(const Lands());
}

class Lands extends StatefulWidget {
  final token;

  const Lands({Key? key, @required this.token}) : super(key: key);

  @override
  _Lands createState() => _Lands();
}

class _Lands extends State<Lands> {
  final LandApiService _apiService = LandApiService();
  late int userId;
  late Future<List<Land>> _lands;
  bool _isAddingLand = false;

  String determineSoilImage(String soilType) {
    switch (soilType) {
      case 'CLAY':
      case 'SILT':
      case 'LOAM':
      case 'SILTY_CLAY':
      case 'SILTY_LOAM':
        return 'lib/assets/images/lands_images/loamy.jpg';

      case 'SAND':
      case 'GRAVELLY':
      case 'ROCKY':
      case 'LOAMY_SAND':
      case 'SANDY_CLAY':
      case 'SANDY_LOAM':
        return 'lib/assets/images/lands_images/rocky.jpeg';

      case 'PEAT':
        return 'lib/assets/images/lands_images/peaty.jpeg';

      case 'CHALKY':
        return 'lib/assets/images/lands_images/chalky.jpeg';

      case 'SALINE':
        return 'lib/assets/images/lands_images/saline.jpeg';

      default:
        return 'lib/assets/images/lands_images/saline.jpeg'; // Default image
    }
  }

  void _showAddLandModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color(0x4D62A06F),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AddLandModal(token: widget.token, userId: userId),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['userId'];
    _lands = _apiService.getAllLandsByUserId(widget.token, userId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            'My Lands',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'PT_Sans'),
          ),
          actions: [
            // Add a plus button to the AppBar
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                setState(() {
                  _isAddingLand = true;
                });
                _showAddLandModal(); // Show the modal bottom sheet
                print('Add New Land');
                // Implement the logic for adding a new land here
                // You can open a new screen or show a dialog for adding a new land
              },
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder<List<Land>>(
            future: _lands,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Or any loading indicator
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                print(
                    'API Response: ${snapshot.data}'); // Print the API response
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Replace with your image asset for land
                    Image.asset(
                      'lib/assets/images/land_icon.png',
                      width: 270,
                      height: 330,
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Implement the logic for adding a new land
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF4BA26A),
                        minimumSize: const Size(300, 50), // Set minimum size
                      ),
                      child: const Text(
                        'Add Land',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                List<Land> lands = snapshot.data!;
                print('API Response: $lands'); // Print the API response
                // Implement the UI for displaying existing lands
                return Expanded(
                  child: ListView.builder(
                    itemCount: lands.length,
                    itemBuilder: (context, index) {
                      String soilType = lands[index].soilType.toString();
                      String imagePath = determineSoilImage(soilType);

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                            color: Color(0xFF4BA26A),
                            width: 2,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            // Ensure you have access to the 'context' variable
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => LandPage(
                                  token: widget.token, // Replace with your actual token
                                  landId: lands[index].landId,
                                  image: determineSoilImage(soilType),
                                ),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(position: offsetAnimation, child: child);
                                },
                              ),
                            );

                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imagePath,
                                  width: 90,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              lands[index].name,
                              style: const TextStyle(
                                fontFamily: 'PT_Sans',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4BA26A),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  lands[index].region,
                                  style: const TextStyle(
                                    fontFamily: 'PT_Sans',
                                    fontSize: 14,
                                    color: Color(0xFF9C9C9C),
                                  ),
                                ),
                              ],
                            ),
                            // Add more details or customize as needed
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
