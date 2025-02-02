import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../search/presentation/screens/search_page.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SearchPage(category: '', token: '', hideCategories: false,)),
        );
      },
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Поиск по магазинам',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Transform.scale(
            scale: 0.65,
            child: SvgPicture.asset(
              'assets/icons/Union.svg',
              width: 16,
              height: 16,
              color: Colors.grey,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18),
        ),
        fillColor: const Color(0xFFF4F4F5),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }
}
