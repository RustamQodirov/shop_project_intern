class NearbyStore {
  final String name;
  final String logo;
  final String phoneNumber;
  final Address address;

  NearbyStore({
    required this.name,
    required this.logo,
    required this.phoneNumber,
    required this.address,
  });

  factory NearbyStore.fromJson(Map<String, dynamic> json) {
    return NearbyStore(
      name: json['name'],
      logo: json['logo'],
      phoneNumber: json['phone_number'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String city;
  final String district;
  final String address;
  final double latitude;
  final double longitude;
  final double distance;

  Address({
    required this.city,
    required this.district,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      address: json['address'] ?? '',
      latitude: (json['latitude'] is int) ? (json['latitude'] as int).toDouble() : json['latitude'].toDouble(),
      longitude: (json['longitude'] is int) ? (json['longitude'] as int).toDouble() : json['longitude'].toDouble(),
      distance: (json['distance'] is int) ? (json['distance'] as int).toDouble() : json['distance'].toDouble(),
    );
  }
}
