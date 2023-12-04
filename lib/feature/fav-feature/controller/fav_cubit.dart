import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/feature/fav-feature/data_source/fav_data_source.dart';

import '../../../core/models/home_model/tourism_model.dart';
import '../../../main.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  static FavCubit get(context) => BlocProvider.of(context);
  FavDataSource favDataSource = FavDataSource();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///todo add fave
  Future<void> addToFav({
    required Map<String, dynamic> model,
    required String id,
  }) async {
    emit(AddToFavLoading());
    try {
      favDataSource.addToFav(model: model,id: id).then((value) {
        emit(AddToFavSuccess());
      });
    } catch (e, s) {
      print(s);
      emit(AddToFavError());
    }
  }

  ///todo remove fave
  Future<void> removeToFav({
    required String modelId,
  }) async {
    emit(RemoveFavLoading());
    try {
      favDataSource.removeToFav(modelId: modelId).then((value) {
        emit(RemoveFavSuccess());
      });
    } catch (e, s) {
      print(s);
      emit(RemoveFavError());
    }
  }
  List<TourismModel> model = [];
  List<String> favId = [];
  ///todo get fave
  Future<void> getToFav() async {
    emit(GetVafLoading());
    try {
      fireStore
          .collection('users')
          .doc(uId)
          .collection('favUser')
          .snapshots()
          .listen((value) {
        model.clear();
        for (var e in value.docs) {
          model.add(TourismModel.fromJson(e.data()));
          print(e.data());
          favId.add(e.id);
        }
        emit(GetVafSuccess());

      });
    } catch (e, s) {
      print(s);
      emit(GetVafError());
    }
  }
}
