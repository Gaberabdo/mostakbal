import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mostakbal/core/local/cache_helper.dart';
import 'package:mostakbal/feature/profile-feature/controller/setting_state.dart';

import '../../../core/models/auth_model/login_model.dart';
import '../data_source/setting_data_source.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(context) => BlocProvider.of<SettingCubit>(context);

  SettingDataSource settingDataSource = SettingDataSource();

  UserDataModel? userDataModel;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///todo get User date
  Future<void> getUserData() async {
    emit(LoadingGetUserdata());
    try {
      fireStore
          .collection('users')
          .doc(
            CacheHelper.getData(
              key: 'uId',
            ),
          )
          .snapshots()
          .listen(
        (event) {
          userDataModel = UserDataModel.fromJson(event.data()!);
          print('*****$userDataModel****');
          emit(SuccessGetUserdata());
        },
      );
    } catch (e, s) {
      emit(ErrorGetUserdata());
      print(s);
    }
  }

  File? profileImage;
  var pickerProfile = ImagePicker();
  Future<void> getProfileImage() async {
    final pickerCover = await pickerProfile.pickImage(
      source: ImageSource.gallery,
    );

    if (pickerCover != null) {
      profileImage = File(pickerCover.path);
      emit(ImagePostSuccess());
    } else {
      print('No image selected.');
      emit(ImagePostError());
    }
  }

  ///todo update User date
  Future<void> updateProfileImage({
    required String phone,
    required String name,
    required String birthdate,
  }) async {
    emit(UpdateLoadingUserDataState());
    try {
      settingDataSource.updateUserDataImage(
        profileImage: profileImage!,
        phone: phone,
        name: name,
        birthdate: birthdate,
      );
      emit(UpdateErrorUserDataState());
    } catch (e, s) {
      emit(UpdateSuccessUserDataState());

      print(s);
    }
  }

  Future<void> updateProfile({
    required String phone,
    required String name,
    required String birthdate,
    String? image,
  }) async {
    emit(UpdateLoadingUserDataState());
    try {
      settingDataSource.updateUserData(
        phone: phone,
        name: name,
        birthdate: birthdate,
      );
      emit(UpdateSuccessUserDataState());
    } catch (e, s) {
      emit(UpdateErrorUserDataState());

      print(s);
    }
  }

  Future<void> verifyEmail() async {
    emit(VerifyEmailLoadingState());
    await FirebaseAuth.instance.currentUser!
        .sendEmailVerification()
        .then((value) {
      emit(VerifyEmailSuccessState());
    }).catchError((onError) {
      print(onError.message.toString());
      emit(VerifyEmailErrorState(onError.message.toString()));
    });
  }
}
