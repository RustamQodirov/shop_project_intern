import 'package:shop/features/investment/home/data/datasource/investment_datasource.dart';
import 'package:shop/features/investment/home/data/model/investment_model.dart';
import 'package:shop/features/investment/home/data/repository/investment_repo.dart';

class InvestmentRepositoryImpl implements InvestmentRepository {
  final InvestmentDataSource dataSource;

  InvestmentRepositoryImpl(this.dataSource);

  @override
  Future<List<Investment>> getInvestments() async {
    return await dataSource.fetchInvestments();
  }
}
