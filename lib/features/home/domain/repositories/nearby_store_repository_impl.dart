import '../../data/datasources/nearby_store_datasource.dart';
import '../../data/model/nearby_store_model.dart';
import 'nearby_store_repository.dart';


class NearbyStoreRepositoryImpl implements NearbyStoreRepository {
  final NearbyStoreDataSource nearbyStoreDataSource;

  NearbyStoreRepositoryImpl({required this.nearbyStoreDataSource});

  @override
  Future<NearbyStoreList> getNearbyStores(String token) async {
    return await nearbyStoreDataSource.fetchNearbyStores(token);
  }
}
