import '../../../data/model/nearby_model.dart';

abstract class NearbyState {}

class NearbyInitial extends NearbyState {}

class NearbyLoading extends NearbyState {}

class NearbyLoaded extends NearbyState {
  final List<NearbyStore> nearbyStores;

  NearbyLoaded({required this.nearbyStores});
}

class NearbyError extends NearbyState {
  final String message;

  NearbyError({required this.message});
}
