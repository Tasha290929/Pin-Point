class ModelLocation {
  // Identity
  final String id;
  final String name;
  final String category;
  final double latitude;
  final double longitude;

  // Preview
  final String? mainImage;
  final String? iconAsset;
  final double? rating;

  // Details screen
  final String fullAddress;
  final String description;
  final List<String> imageUrls;
  final String? workingHours;
  final String? phoneNumber;
  final Map<String, String>? additionalInfo;

  const ModelLocation({
    required this.id,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
    this.mainImage,
    this.iconAsset,
    this.rating,
    required this.fullAddress,
    required this.description,
    this.imageUrls = const [],
    this.workingHours,
    this.phoneNumber,
    this.additionalInfo,
  });
}