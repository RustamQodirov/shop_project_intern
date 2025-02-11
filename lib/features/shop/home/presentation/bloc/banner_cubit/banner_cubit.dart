import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/shop/home/data/model/banner_model.dart';
import 'package:shop/features/shop/home/data/repository/banner_repository.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannerRepository bannerRepository;

  BannerCubit({required this.bannerRepository}) : super(BannerInitial());

  Future<void> fetchBanners(String token) async {
    try {
      emit(BannerLoading());
      final banners = await bannerRepository.getBanners(token);
      emit(BannerLoaded(banners));
    } catch (e) {
      emit(BannerError('Failed to load banners'));
    }
  }
}
