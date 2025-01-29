import 'package:flutter/material.dart';

import '../../data/model/store_model.dart';

class StoreList extends StatelessWidget {
  final List<Store> stores;

  const StoreList({Key? key, required this.stores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store = stores[index];
        final storeIcon = store.logo;
        final storeName = store.name;

        // If no image is available or the name is missing, don't show the item
        if (storeIcon == null || storeName == null) {
          return Container(); // Or you can show a placeholder or remove the item
        }

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: storeIcon.isNotEmpty
                ? Image.network(storeIcon, width: 50, height: 50)
                : const Icon(Icons.store, size: 50), // Placeholder icon
          ),
          title: Text(
            storeName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            // Handle store selection, maybe navigate to store details
            _onStoreSelected(context, store);
          },
        );
      },
    );
  }

  void _onStoreSelected(BuildContext context, Store store) {
    // Implement logic for handling store selection, for example:
    // Navigate to store details page or show more information
    print('Store selected: ${store.name}');
    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => StoreDetailPage(store: store)));
  }
}