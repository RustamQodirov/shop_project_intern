import '../../data/datasources/banner_datasource.dart';
import '../../data/model/banner_model.dart';
import '../../data/repository/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerDataSource bannerDataSource;

  BannerRepositoryImpl({required this.bannerDataSource});

  @override
  Future<List<BannerModel>> getBanners(String token) {
    return bannerDataSource.fetchBanners(token);
  }
}
