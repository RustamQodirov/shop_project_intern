class Category {
  final String guid;
  final String slug;
  final String title;
  final String banner;

  Category({
    required this.guid,
    required this.slug,
    required this.title,
    required this.banner,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      guid: json['Guid'],
      slug: json['Slug'],
      title: json['Title'],
      banner: json['Banner'] ?? '',
    );
  }
}
