import 'package:bloc/bloc.dart';
import 'package:shop/features/investment/home/data/repository/investment_repo.dart';
import 'package:shop/features/investment/home/presentation/bloc/investment_state.dart';

class InvestmentCubit extends Cubit<InvestmentState> {
  final InvestmentRepository repository;

  InvestmentCubit(this.repository) : super(InvestmentInitial());

  Future<void> fetchInvestments() async {
    try {
      emit(InvestmentLoading());
      final investments = await repository.getInvestments();
      emit(InvestmentLoaded(investments));
    } catch (e) {
      emit(InvestmentError(e.toString()));
    }
  }
}
