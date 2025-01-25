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
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      distance: json['distance']?.toDouble() ?? 0.0,
    );
  }
}

class NearbyStore {
  final String guid;
  final String name;
  final String logo;
  final String phoneNumber;
  final Address address;

  NearbyStore({
    required this.guid,
    required this.name,
    required this.logo,
    required this.phoneNumber,
    required this.address,
  });

  factory NearbyStore.fromJson(Map<String, dynamic> json) {
    return NearbyStore(
      guid: json['guid'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      address: Address.fromJson(json['address']),
    );
  }
}

class NearbyStoreList {
  final List<NearbyStore> stores;

  NearbyStoreList({required this.stores});

  factory NearbyStoreList.fromJson(Map<String, dynamic> json) {
    var list = json['data']['list'] as List;
    List<NearbyStore> storesList = list.map((i) => NearbyStore.fromJson(i)).toList();
    return NearbyStoreList(stores: storesList);
  }
}
