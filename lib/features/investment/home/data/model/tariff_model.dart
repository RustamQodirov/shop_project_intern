class Tariff {
  final String guid;
  final String titleEng;
  final String titleUz;
  final String titleRu;
  final int typeId;
  final int startValue;
  final int maxValue;
  final String forecast;
  final String forecastCapitalized;
  final int terms;
  final bool show;
  final String group;
  final double fine;
  final String currency;

  Tariff({
    required this.guid,
    required this.titleEng,
    required this.titleUz,
    required this.titleRu,
    required this.typeId,
    required this.startValue,
    required this.maxValue,
    required this.forecast,
    required this.forecastCapitalized,
    required this.terms,
    required this.show,
    required this.group,
    required this.fine,
    required this.currency,
  });

  factory Tariff.fromJson(Map<String, dynamic> json) {
    return Tariff(
      guid: json['guid'],
      titleEng: json['title_eng'],
      titleUz: json['title_uz'],
      titleRu: json['title_ru'],
      typeId: json['type_id'],
      startValue: json['start_value'],
      maxValue: json['max_value'],
      forecast: json['forecast'],
      forecastCapitalized: json['forecast_capitalized'],
      terms: json['terms'],
      show: json['show'],
      group: json['group'],
      fine: json['fine'].toDouble(),
      currency: json['currency'],
    );
  }
}