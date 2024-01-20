class RecommendationResponse {
  final int recommendationId;
  final int landId;
  final String cropName;
  final String reasonWhy;

  RecommendationResponse({
    required this.recommendationId,
    required this.landId,
    required this.cropName,
    required this.reasonWhy,
  });

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) {
    return RecommendationResponse(
      recommendationId: json['recommendationId'],
      landId: json['landId'],
      cropName: json['cropName'],
      reasonWhy: json['reasonWhy'],
    );
  }

}
