import 'package:flutter/material.dart';
import 'package:cropmate/services/land_api_service.dart';

import '../models/Levels.dart';
import '../models/SoilTypes.dart';
import '../models/land_model.dart';

class AddLandModal extends StatefulWidget {
  final token;
  final userId;
  const AddLandModal({Key? key,@required this.token, @required this.userId}) : super(key: key);

  @override
  _AddLandModalState createState() => _AddLandModalState();
}

class _AddLandModalState extends State<AddLandModal> {
  final LandApiService _apiService = LandApiService();
  Color customColor = const Color(0xFFB0ABAB);
  String name = '';
  String region = '';
  double phLevel = 0;
  SoilTypes? soilType;
  Levels? nitrogen;
  Levels? phosphorus;
  Levels? potassium;
  Levels? moistureLevel;
  double temperature = 0.0;

  void _addLand(name, region, phLevel, soilType, nitrogen, phosphorus, potassium, moistureLevel, temperature) async {
    Land myLand = Land(
      name: name,
      userId: widget.userId,
      region: region,
      phLevel: phLevel,
      soilType: soilType,
      nitrogen: nitrogen,
      phosphorus: phosphorus,
      potassium: potassium,
      moistureLevel: moistureLevel,
      temperature: temperature,
    );
    print(myLand.toJson());
    try {
      await _apiService.addLand(widget.token, myLand);
    } catch (error) {
      // Handle errors appropriately
      print('Error adding land: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color(0xFFB0ABAB); // Convert hex to Color object

    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0x4D62A06F),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add New Land',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: 'PT_Sans'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                cursorColor: customColor,
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Region',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                cursorColor: customColor,
                onChanged: (value) {
                  region = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ph Level',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                cursorColor: customColor,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  phLevel = double.parse(value.toString());
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Temperature',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                  TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                keyboardType: TextInputType.number,
                cursorColor: customColor,
                onChanged: (value) {
                  temperature = double.parse(value.toString());
                },
              ),
              DropdownButtonFormField<SoilTypes>(
                decoration: const InputDecoration(
                  labelText: 'Soil Type',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                items: SoilTypes.values.map((type) {
                  return DropdownMenuItem<SoilTypes>(
                    value: type,
                    child: Text(type.toString().split('.').last,
                        style: TextStyle(
                            color: customColor, fontFamily: 'PT_Sans')),
                  );
                }).toList(),
                onChanged: (value) {
                  soilType = value;
                },
              ),
              DropdownButtonFormField<Levels>(
                decoration: const InputDecoration(
                  labelText: 'Nitrogen',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                items: Levels.values.map((level) {
                  return DropdownMenuItem<Levels>(
                    value: level,
                    child: Text(level.toString().split('.').last,
                        style: TextStyle(
                            color: customColor, fontFamily: 'PT_Sans')),
                  );
                }).toList(),
                onChanged: (Levels? value) {
                  nitrogen = value;
                },
              ),
              DropdownButtonFormField<Levels>(
                decoration: const InputDecoration(
                  labelText: 'Phosphorus',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                items: Levels.values.map((level) {
                  return DropdownMenuItem<Levels>(
                    value: level,
                    child: Text(level.toString().split('.').last,
                        style: TextStyle(
                            color: customColor, fontFamily: 'PT_Sans')),
                  );
                }).toList(),
                onChanged: (Levels? value) {
                  phosphorus = value;
                },
              ),
              DropdownButtonFormField<Levels>(
                decoration: const InputDecoration(
                  labelText: 'Potassium',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                items: Levels.values.map((level) {
                  return DropdownMenuItem<Levels>(
                    value: level,
                    child: Text(level.toString().split('.').last,
                        style: TextStyle(
                            color: customColor, fontFamily: 'PT_Sans')),
                  );
                }).toList(),
                onChanged: (Levels? value) {
                  potassium = value;
                },
              ),
              DropdownButtonFormField<Levels>(
                decoration: const InputDecoration(
                  labelText: 'Moisture',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'PT_Sans'),
                ),
                items: Levels.values.map((level) {
                  return DropdownMenuItem<Levels>(
                    value: level,
                    child: Text(level.toString().split('.').last,
                        style: TextStyle(
                            color: customColor, fontFamily: 'PT_Sans')),
                  );
                }).toList(),
                onChanged: (Levels? value) {
                  moistureLevel = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    _addLand(name, region, phLevel, soilType, nitrogen, phosphorus, potassium, moistureLevel, temperature);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF62A06F), // Set your desired color
                    padding: const EdgeInsets.all(15.0),
                  ),
                  child: const Text(
                    'Add Land',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'PT_Sans'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
