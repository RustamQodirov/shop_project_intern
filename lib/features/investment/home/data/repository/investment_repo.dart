
import 'package:shop/features/investment/home/data/model/investment_model.dart';

abstract class InvestmentRepository {
  Future<List<Investment>> getInvestments();
}