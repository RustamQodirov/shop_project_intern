import 'package:shop/features/investment/home/data/datasource/tariff_datasource.dart';
import 'package:shop/features/investment/home/data/model/tariff_model.dart';
import 'package:shop/features/investment/home/data/repository/tariff_repo.dart';

class TariffRepositoryImpl implements TariffRepository {
  final ApiService apiService;

  TariffRepositoryImpl(this.apiService);

  @override
  Future<List<Tariff>> getTariffs() async {
    return await apiService.fetchTariffs();
  }
}
