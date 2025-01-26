import '../../data/datasources/recommended_store_datasource.dart';
import '../../data/model/recommended_store_model.dart';
import '../../data/repository/recommended_store_repository.dart';

class RecommendedStoreRepositoryImpl implements RecommendedStoreRepository {
  final RecommendedStoreDataSource dataSource;

  RecommendedStoreRepositoryImpl({required this.dataSource});

  @override
  Future<List<RecommendedStore>> getRecommendedStores(String token) {
    return dataSource.fetchRecommendedStores(token);
  }
}
