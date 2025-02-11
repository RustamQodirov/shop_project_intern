class RecommendedStore {
  final String guid;
  final String name;
  final String logo;

  RecommendedStore({
    required this.guid,
    required this.name,
    required this.logo,
  });

  factory RecommendedStore.fromJson(Map<String, dynamic> json) {
    return RecommendedStore(
      guid: json['guid'] as String,
      name: json['name'] as String,
      logo: json['logo'] ?? '',
    );
  }
}
