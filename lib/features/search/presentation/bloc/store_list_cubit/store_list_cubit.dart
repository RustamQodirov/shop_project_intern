import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/datasource/store_datasource.dart';
import '../../../data/model/store_model.dart';


part 'store_list_state.dart';

class StoreListCubit extends Cubit<StoreListState> {
  final StoreDataSource storeDataSource;

  StoreListCubit({required this.storeDataSource}) : super(StoreListInitial());

  // Fetch stores using the token and emit appropriate states
  Future<void> fetchStores(String token) async {
    emit(StoreListLoading());

    try {
      final stores = await storeDataSource.fetchStores(token);
      emit(StoreListLoaded(stores: stores));
    } catch (e) {
      emit(StoreListError(message: e.toString()));
    }
  }
}
