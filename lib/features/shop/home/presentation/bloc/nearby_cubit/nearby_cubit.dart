import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/nearby_repository.dart';
import 'nearby_state.dart';

class NearbyCubit extends Cubit<NearbyState> {
  final NearbyRepository nearbyRepository;

  NearbyCubit({required this.nearbyRepository}) : super(NearbyInitial());

  void fetchNearbyStores(String token) async {
    try {
      emit(NearbyLoading());
      final nearbyStores = await nearbyRepository.getNearbyStores(token);
      emit(NearbyLoaded(nearbyStores: nearbyStores));
    } catch (e) {
      emit(NearbyError(message: e.toString()));
    }
  }
}
