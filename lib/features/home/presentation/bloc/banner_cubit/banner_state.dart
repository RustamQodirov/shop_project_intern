part of 'banner_cubit.dart';

abstract class BannerState {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final List<BannerModel> banners;

  const BannerLoaded(this.banners);

  @override
  List<Object> get props => [banners];
}

class BannerError extends BannerState {
  final String message;

  const BannerError(this.message);

  @override
  List<Object> get props => [message];
}
