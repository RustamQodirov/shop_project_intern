import 'package:flutter/material.dart';
import 'package:shop/features/home/data/model/category_model.dart';

import '../../data/model/stored_data.dart';

class StoreList extends StatelessWidget {
  const StoreList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: StoreData.stores.map((data) {
        return ListTile(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(data['icon']!, width: 50, height: 50),
          ),
          title: Text(
            data['name']!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            // Handle store selection
          },
        );
      }).toList(),
    );
  }
}