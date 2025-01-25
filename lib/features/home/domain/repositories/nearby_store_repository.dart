import '../../data/model/nearby_store_model.dart';

abstract class NearbyStoreRepository {
  Future<NearbyStoreList> getNearbyStores(String token);
}
