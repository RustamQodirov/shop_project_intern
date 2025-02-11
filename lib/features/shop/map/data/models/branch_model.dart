class Branch {
  final String guid;
  final String name;
  final String logo;
  final String phoneNumber;
  final String address;
  final double latitude;
  final double longitude;
  late final double distance;

  Branch({
    required this.guid,
    required this.name,
    required this.logo,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      guid: json['guid'],
      name: json['name'],
      logo: json['logo'] ?? '',
      phoneNumber: json['phone_number'],
      address: json['address']['address'],
      latitude: json['address']['latitude'].toDouble(),
      longitude: json['address']['longitude'].toDouble(),
      distance: json['address']['distance'].toDouble(),
    );
  }
}