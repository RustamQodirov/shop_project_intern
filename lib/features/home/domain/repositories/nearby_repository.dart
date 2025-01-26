import '../../data/model/nearby_model.dart';

abstract class NearbyRepository {
  Future<List<NearbyStore>> getNearbyStores(String token);
}
