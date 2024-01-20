// Import statements (if not already present)
import 'package:flutter/material.dart';
import '../models/crop_response.dart';
import '../services/crop_api_service.dart';
import '../widgets/image_slider.dart';
import '../widgets/navbar.dart';

class CropPage extends StatefulWidget {
  final String token;
  final int cropId;

  const CropPage({Key? key, required this.token, required this.cropId})
      : super(key: key);

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  late Future<CropResponse> _cropFuture;
  final CropServiceApi _cropServiceApi = CropServiceApi();
  String currentSection = 'Information';

  @override
  void initState() {
    super.initState();
    _cropFuture = _cropServiceApi.getCropById(widget.cropId);
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Crop Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'PT_Sans',
          ),
        ),
      ),
      body: FutureBuilder<CropResponse>(
        future: _cropFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            CropResponse crop = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ImageSlider(
                    image1: crop.cropImagePath,
                    image2: crop.cropImagePath2,
                    image3: crop.cropImagePath3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSection = 'Information';
                            });
                          },
                          child: Text(
                            'Information',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: currentSection == 'Information'
                                  ? Colors.green
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSection = 'Agricultural Details';
                            });
                          },
                          child: Text(
                            'Agricultural Details',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: currentSection == 'Agricultural Details'
                                  ? Colors.green
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSection = 'Market and Cultivation';
                            });
                          },
                          child: Text(
                            'Market and Cultivation',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: currentSection == 'Market and Cultivation'
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getContentForSection(currentSection, crop),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget getContentForSection(String section, CropResponse crop) {
    switch (section) {
      case 'Information':
        return informationSection(crop);
      case 'Agricultural Details':
        return agriculturalDetailsSection(crop);
      case 'Market and Cultivation':
        return marketCultivationSection(crop);
      default:
        return Container();
    }
  }

  Widget informationSection(CropResponse crop) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _informationItem('Crop Name', crop.cropName),
          _informationItem('Crop Type', crop.cropType),
          _informationItem('Soil Type', crop.soilType),
          _informationItem('Soil pH', crop.soilPH.toString()),
          _informationItem('Soil Drainage', crop.soilDrainage),
          _informationItem('Temperature (F)', crop.temperature),
          _informationItem('Precipitation (mm)', crop.precipitation.toString()),
          _informationItem('Growing Season Days', crop.growingSeasonDays),
        ],
      ),
    );
  }

  Widget agriculturalDetailsSection(CropResponse crop) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _informationItem('Watering Needs (l/day)', crop.wateringNeeds.toString()),
          _informationItem('NPK', crop.nutrientRequirements),
          _informationItem('Pest Resistance', '${crop.pestResistance}/5'),
          _informationItem('Disease Resistance', '${crop.diseaseResistance}/5'),
          _informationItem('Crop Rotation Suitability', crop.cropRotationSuitability),
          _informationItem('Average Yield (m2)', crop.averageYield.toString()),
        ],
      ),
    );
  }

  Widget marketCultivationSection(CropResponse crop) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _informationItem('Market Demand', '${crop.marketDemand}/5'),
          _informationItem('Cultivation Techniques', crop.cultivationTechniques),
          _informationItem('Secondary Cultivation Techniques ', crop.cultivationTechniques2),
          _informationItem('Harvesting Period', crop.harvestingPeriod),
          _informationItem('Storage Conditions', crop.storageConditions),
          _informationItem('Secondary Storage Conditions', crop.storageConditions2),
        ],
      ),
    );
  }

  Widget _informationItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color(0xFF4BA26A),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'PT_Sans',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: 'PT_Sans',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
