import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/recommended_store_repository.dart';
import 'recommended_store_state.dart';

class RecommendedStoreCubit extends Cubit<RecommendedStoreState> {
  final RecommendedStoreRepository repository;

  RecommendedStoreCubit({required this.repository}) : super(RecommendedStoreInitial());

  Future<void> fetchRecommendedStores(String token) async {
    emit(RecommendedStoreLoading());
    try {
      final stores = await repository.getRecommendedStores(token);
      emit(RecommendedStoreLoaded(stores));
    } catch (error) {
      emit(RecommendedStoreError(error.toString()));
    }
  }
}
