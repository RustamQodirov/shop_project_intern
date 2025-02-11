// home_page_data.dart

class HomePageData {
  static const List<Map<String, String>> categories = [
    {'icon': 'assets/images/laptop.png', 'label': 'Электроника'},
    {'icon': 'assets/images/phone.png', 'label': 'Смартфоны'},
    {'icon': 'assets/images/machine.png', 'label': 'Бытовая техника'},
    {'icon': 'assets/images/sofa.png', 'label': 'Мебель'},
    {'icon': 'assets/images/car1.png', 'label': 'Авто товары'},
    {'icon': 'assets/images/bear.png', 'label': 'Игрушки'},
  ];

  static const List<Map<String, String>> recommendedStores = [
    {
      'name': 'Elmakon',
      'image': 'assets/images/player.png',
      'logo': 'assets/images/el.png',
    },
    {
      'name': 'Texnomart',
      'image': 'assets/images/earphone.png',
      'logo': 'assets/images/tex.png',
    },
    {
      'name': 'Idea',
      'image': 'assets/images/earphone.png',
      'logo': 'assets/images/idea.png',
    },
  ];

  static const List<Map<String, String>> nearbyStores = [
    {'name': 'Store 1', 'image': 'assets/images/store1.png'},
    {'name': 'Store 2', 'image': 'assets/images/store2.png'},
    {'name': 'Store 3', 'image': 'assets/images/store3.png'},
  ];
}
