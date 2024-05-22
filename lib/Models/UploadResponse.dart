class UploadResponse {
  final String diseaseName;
  final String imageUrl;

  UploadResponse({
    required this.diseaseName,
    required this.imageUrl,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      diseaseName: json['disease_name'],
      imageUrl: json['image_url'],
    );
  }
}
