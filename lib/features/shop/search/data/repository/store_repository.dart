import '../model/store_model.dart';

abstract class StoreRepository {
  Future<List<Store>> getStores(String token);
}
