class ModelProfile {
  final String name;
  final String? avatarUrl;
  final String email;
  final String phone;
  final String city;

  const ModelProfile({
    required this.name,
    this.avatarUrl,
    required this.email,
    required this.phone,
    required this.city,
  });
}