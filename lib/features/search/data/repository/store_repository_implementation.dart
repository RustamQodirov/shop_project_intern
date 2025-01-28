import 'package:shop/features/search/data/repository/store_repository.dart';

import '../datasource/store_datasource.dart';
import '../model/store_model.dart';

class StoreRepositoryImplementation implements StoreRepository {
  final StoreDataSource dataSource;

  StoreRepositoryImplementation({required this.dataSource});

  @override
  Future<List<Store>> getStores(String token) {
    return dataSource.fetchStores(token);
  }
}
