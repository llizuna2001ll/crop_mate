import 'package:flutter/material.dart';
import '../models/crop_response.dart';
import '../services/crop_api_service.dart';
import 'CropPage.dart';
import 'home.dart';

class Crops extends StatefulWidget {
  final token;

  const Crops({Key? key, @required this.token}) : super(key: key);

  @override
  _CropsState createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  final CropServiceApi _cropServiceApi = CropServiceApi();
  late Future<List<CropResponse>> _cropsFuture;
  late List<CropResponse> _filteredCrops; // New variable for filtered crops

  @override
  void initState() {
    super.initState();
    _cropsFuture = _cropServiceApi.getAllCrops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                pageBuilder: (context, animation, secondaryAnimation) => Home(token: widget.token),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeOutCubic;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
          'Crops',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'PT_Sans',
          ),
        ),
        actions: [
          // Add a search bar
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black,
            onPressed: () async {
              final String? selectedCrop = await showSearch(
                context: context,
                delegate: CropSearchDelegate(_filteredCrops),
              );
              // Handle selected crop if needed
            },
          ),
        ],
      ),
      body: FutureBuilder<List<CropResponse>>(
        future: _cropsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<CropResponse> crops = snapshot.data!;
            _filteredCrops = crops; // Initialize filtered crops

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
              ),
              itemCount: _filteredCrops.length,
              itemBuilder: (context, index) {
                String iconPath = '';
                String cropType = _filteredCrops[index].cropType.toLowerCase();

                switch (cropType) {
                  case 'grains':
                    iconPath = 'lib/assets/images/crop_types/grains_icon.png';
                    break;
                  case 'legumes':
                    iconPath = 'lib/assets/images/crop_types/legumes_icon.png';
                    break;
                  case 'vegetables':
                    iconPath =
                        'lib/assets/images/crop_types/vegetables_icon.png';
                    break;
                  case 'roots':
                    iconPath = 'lib/assets/images/crop_types/roots_icon.png';
                    break;
                  case 'other':
                    iconPath = 'lib/assets/images/crop_types/others_icon.png';
                    break;
                  case 'fruits':
                    iconPath = 'lib/assets/images/crop_types/fruits_icon.png';
                    break;
                  default:
                    // You may want to provide a default icon here
                    iconPath = 'lib/assets/images/crop_types/default_icon.png';
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CropPage(
                              cropId: _filteredCrops[index].cropId,
                              token: widget.token),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.transparent
                            ),
                          ),
                          child: Image.asset(
                            iconPath,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _filteredCrops[index].cropName,
                          style: const TextStyle(
                            fontFamily: 'PT_Sans',
                            color: Color(0xFF4BA26A),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CropSearchDelegate extends SearchDelegate<String> {
  final List<CropResponse> crops;

  CropSearchDelegate(this.crops);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(query);
  }

  Widget _buildSearchResults(String query) {
    final List<CropResponse> filteredCrops = crops
        .where(
            (crop) => crop.cropName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemCount: filteredCrops.length,
      itemBuilder: (context, index) {
        String iconPath = '';
        String cropType = filteredCrops[index].cropType.toLowerCase();

        switch (cropType) {
          case 'grains':
            iconPath = 'lib/assets/images/crop_types/grains_icon.png';
            break;
          case 'legumes':
            iconPath = 'lib/assets/images/crop_types/legumes_icon.png';
            break;
          case 'vegetables':
            iconPath = 'lib/assets/images/crop_types/vegetables_icon.png';
            break;
          case 'roots':
            iconPath = 'lib/assets/images/crop_types/roots_icon.png';
            break;
          case 'other':
            iconPath = 'lib/assets/images/crop_types/others_icon.png';
            break;
          case 'fruits':
            iconPath = 'lib/assets/images/crop_types/fruits_icon.png';
            break;
          default:
            // You may want to provide a default icon here
            iconPath = 'lib/assets/images/crop_types/default_icon.png';
        }

        return Column(
          children: [
            Image.asset(
              iconPath,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 8),
            Text(
              filteredCrops[index].cropName,
              style: const TextStyle(
                fontFamily: 'PT_Sans',
              ),
            ),
          ],
        );
      },
    );
  }
}
