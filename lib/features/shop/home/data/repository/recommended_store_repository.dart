import '../model/recommended_store_model.dart';

abstract class RecommendedStoreRepository {
  Future<List<RecommendedStore>> getRecommendedStores(String token);
}
