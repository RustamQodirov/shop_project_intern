import '../../data/datasources/nearby_datasource.dart';
import '../../data/model/nearby_model.dart';
import '../../data/repository/nearby_repository.dart';


class NearbyRepositoryImpl implements NearbyRepository {
  final NearbyDataSource nearbyDataSource;

  NearbyRepositoryImpl({required this.nearbyDataSource});

  @override
  Future<List<NearbyStore>> getNearbyStores(String token) async {
    return await nearbyDataSource.fetchNearbyStores(token);
  }
}
