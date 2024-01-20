import 'package:cropmate/models/SoilTypes.dart';
import 'package:cropmate/models/recommendation_response.dart';
import 'package:cropmate/models/user_model.dart';

import 'Levels.dart';

class Land {
  final int? landId;
  final int userId;
  final String name;
  final String region;
  final double phLevel;
  final SoilTypes soilType;
  final Levels nitrogen;
  final Levels phosphorus;
  final Levels potassium;
  final Levels moistureLevel;
  final double temperature;
  final List<RecommendationResponse>? recommendations;
  final User? user;

  Land({
    this.landId,
    required this.name,
    required this.userId,
    required this.region,
    required this.phLevel,
    required this.soilType,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.moistureLevel,
    required this.temperature,
    this.recommendations,
    this.user,
  });

  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
      landId: json['landId'] as int,
      userId: json['userId'] as int,
      name: json['name'] as String,
      region: json['region'] as String,
      phLevel: json['phLevel'] as double,
      soilType: _parseSoilType(json['soilType']),
      nitrogen: _parseLevel(json['nitrogen']),
      phosphorus: _parseLevel(json['phosphorus']),
      potassium: _parseLevel(json['potassium']),
      moistureLevel: _parseLevel(json['moistureLevel']),
      temperature: json['temperature'] as double,
      recommendations: (json['recommendations'] as List<dynamic>?)?.map((data) => RecommendationResponse.fromJson(data)).toList() ?? [],
      user: json['user'] != null ? User.fromJson(json['user']) : User(username: '', email: '', address: '', contactNumber: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'landId': landId,
      'name': name,
      'userId': userId,
      'region': region,
      'phLevel': phLevel,
      'soilType': soilType.toString().split('.').last, // Convert SoilTypes enum to String
      'nitrogen': nitrogen.toString().split('.').last, // Convert Levels enum to String
      'phosphorus': phosphorus.toString().split('.').last, // Convert Levels enum to String
      'potassium': potassium.toString().split('.').last, // Convert Levels enum to String
      'moistureLevel': moistureLevel.toString().split('.').last, // Convert Levels enum to String
      'temperature': temperature,
    };
  }


  static SoilTypes _parseSoilType(String soilTypeString) {
    switch (soilTypeString) {
      case 'CLAY':
        return SoilTypes.CLAY;
      case 'SAND':
        return SoilTypes.SAND;
      case 'LOAM':
        return SoilTypes.LOAM;
      case 'SILT':
        return SoilTypes.SILT;
      case 'PEAT':
        return SoilTypes.PEAT;
      case 'CHALKY':
        return SoilTypes.CHALKY;
      case 'ROCKY':
        return SoilTypes.ROCKY;
      case 'GRAVELLY':
        return SoilTypes.GRAVELLY;
      case 'SALINE':
        return SoilTypes.SALINE;
      case 'LOAMY_SAND':
        return SoilTypes.LOAMY_SAND;
      case 'SILTY_CLAY':
        return SoilTypes.SILTY_CLAY;
      case 'SILTY_LOAM':
        return SoilTypes.SILTY_LOAM;
      case 'SANDY_CLAY':
        return SoilTypes.SANDY_CLAY;
      case 'SANDY_LOAM':
        return SoilTypes.SANDY_LOAM;
      default:
        throw ArgumentError('Invalid soilTypeString: $soilTypeString');
    }
  }

  static Levels _parseLevel(String levelString) {
    switch (levelString) {
      case 'LOW':
        return Levels.LOW;
      case 'MEDIUM':
        return Levels.MEDIUM;
      case 'HIGH':
        return Levels.HIGH;
      default:
        throw ArgumentError('Invalid levelString: $levelString');
    }
  }
}
