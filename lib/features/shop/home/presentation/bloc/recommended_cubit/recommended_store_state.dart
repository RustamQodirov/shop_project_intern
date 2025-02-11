import '../../../data/model/recommended_store_model.dart';


abstract class RecommendedStoreState {}

class RecommendedStoreInitial extends RecommendedStoreState {}

class RecommendedStoreLoading extends RecommendedStoreState {}

class RecommendedStoreLoaded extends RecommendedStoreState {
  final List<RecommendedStore> stores;

  RecommendedStoreLoaded(this.stores);
}

class RecommendedStoreError extends RecommendedStoreState {
  final String message;

  RecommendedStoreError(this.message);
}
