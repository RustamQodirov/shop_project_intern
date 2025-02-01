class Store {
  final String guid;
  final String name;
  final String? logo;
  final String phoneNumber;
  final String address;
  final double latitude;
  final double longitude;

  Store({
    required this.guid,
    required this.name,
    this.logo,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      guid: json['guid'],
      name: json['name'],
      logo: json['logo'],
      phoneNumber: json['phone_number'],
      address: json['address']['address'],
      latitude: (json['address']['latitude'] as num).toDouble(),
      longitude: (json['address']['longitude'] as num).toDouble(),
    );
  }
}
