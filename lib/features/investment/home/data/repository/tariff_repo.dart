import 'package:shop/features/investment/home/data/datasource/tariff_datasource.dart';
import 'package:shop/features/investment/home/data/model/tariff_model.dart';

class TariffRepository {
  final ApiService apiService;

  TariffRepository(this.apiService);

  Future<List<Tariff>> getTariffs() async {
    return await apiService.fetchTariffs();
  }
}
