class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class TashkentLocation extends AppLatLong {
  const TashkentLocation({
    super.lat = 41.3111,  // Latitude of Tashkent
    super.long = 69.2797, // Longitude of Tashkent
  });
}
