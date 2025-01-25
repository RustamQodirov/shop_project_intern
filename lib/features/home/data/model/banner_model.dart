class BannerModel {
  final String id;
  final String name;
  final String link;
  final String imageUrl;

  BannerModel({
    required this.id,
    required this.name,
    required this.link,
    required this.imageUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    final language = 'en'; // Or any dynamic language you need
    return BannerModel(
      id: json['id'],
      name: json['name'],
      link: json['link'],
      imageUrl: json['attributes'][language]['url'],
    );
  }
}
