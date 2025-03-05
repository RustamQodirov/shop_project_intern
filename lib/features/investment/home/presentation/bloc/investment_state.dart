
import 'package:shop/features/investment/home/data/model/investment_model.dart';

abstract class InvestmentState {}

class InvestmentInitial extends InvestmentState {}

class InvestmentLoading extends InvestmentState {}

class InvestmentLoaded extends InvestmentState {
  final List<Investment> investments;

  InvestmentLoaded(this.investments);
}

class InvestmentError extends InvestmentState {
  final String message;

  InvestmentError(this.message);
}