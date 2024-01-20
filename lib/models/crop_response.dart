class CropResponse {
  late final int cropId;
  late final String cropName;
  late final String cropType;
  late final String soilType;
  late final double soilPH;
  late final String soilDrainage;
  late final String temperature;
  late final double precipitation;
  late final String growingSeasonDays;
  late final double wateringNeeds;
  late final String nutrientRequirements;
  late final int pestResistance;
  late final int diseaseResistance;
  late final String cropRotationSuitability;
  late final double averageYield;
  late final int marketDemand;
  late final String cultivationTechniques;
  late final String cultivationTechniques2;
  late final String harvestingPeriod;
  late final String storageConditions;
  late final String storageConditions2;
  late final String cropImagePath;
  late final String cropImagePath2;
  late final String cropImagePath3;
  late final String iconPath;

  CropResponse({
    required this.cropId,
    required this.cropName,
    required this.cropType,
    required this.soilType,
    required this.soilPH,
    required this.soilDrainage,
    required this.temperature,
    required this.precipitation,
    required this.growingSeasonDays,
    required this.wateringNeeds,
    required this.nutrientRequirements,
    required this.pestResistance,
    required this.diseaseResistance,
    required this.cropRotationSuitability,
    required this.averageYield,
    required this.marketDemand,
    required this.cultivationTechniques,
    required this.cultivationTechniques2,
    required this.harvestingPeriod,
    required this.storageConditions,
    required this.storageConditions2,
    required this.cropImagePath,
    required this.cropImagePath2,
    required this.cropImagePath3,
    required this.iconPath
  });

  factory CropResponse.fromJson(Map<String, dynamic> json) {
    return CropResponse(
      cropId: json['cropId'],
      cropName: json['cropName'],
      cropType: json['cropType'],
      soilType: json['soilType'],
      soilPH: json['soilPH'].toDouble(),
      soilDrainage: json['soilDrainage'],
      temperature: json['temperature'],
      precipitation: json['precipitation'].toDouble(),
      growingSeasonDays: json['growingSeasonDays'],
      wateringNeeds: json['wateringNeeds'].toDouble(),
      nutrientRequirements: json['nutrientRequirements'],
      pestResistance: json['pestResistance'],
      diseaseResistance: json['diseaseResistance'],
      cropRotationSuitability: json['cropRotationSuitability'],
      averageYield: json['averageYield'].toDouble(),
      marketDemand: json['marketDemand'],
      cultivationTechniques: json['cultivationTechniques'],
      cultivationTechniques2: json['cultivationTechniques2'],
      harvestingPeriod: json['harvestingPeriod'],
      storageConditions: json['storageConditions'],
      storageConditions2: json['storageConditions2'],
      cropImagePath: json['cropImagePath'],
      cropImagePath2: json['cropImagePath2'],
      cropImagePath3: json['cropImagePath3'],
      iconPath: json['iconPath'],
    );
  }
}
