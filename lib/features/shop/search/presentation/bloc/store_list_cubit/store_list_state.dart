part of 'store_list_cubit.dart';

@immutable
abstract class StoreListState {}

class StoreListInitial extends StoreListState {}

class StoreListLoading extends StoreListState {}

class StoreListLoaded extends StoreListState {
  final List<Store> stores;

  StoreListLoaded({required this.stores});
}

class StoreListError extends StoreListState {
  final String message;

  StoreListError({required this.message});
}
