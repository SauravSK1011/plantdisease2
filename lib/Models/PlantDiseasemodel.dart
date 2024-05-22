class PlantDisease {
  final String name;
  final String pesticides;
  final String fertilizers;
  final String culturalPractices;

  PlantDisease({
    required this.name,
    required this.pesticides,
    required this.fertilizers,
    required this.culturalPractices,
  });

  factory PlantDisease.fromJson(Map<String, dynamic> json) {
    return PlantDisease(
      name: json.keys.first,
      pesticides: json.values.first['Pesticides'] ?? '',
      fertilizers: json.values.first['Fertilizers'] ?? '',
      culturalPractices: json.values.first['Cultural Practices'] ?? '',
    );
  }
}
