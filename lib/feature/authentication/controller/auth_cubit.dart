import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mostakbal/feature/authentication/data_source/auth_data_source.dart';

import '../../../core/models/auth_model/login_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    required String email,
    required String username,
    required String phone,
    required String password,
    required String fullName,
    required String birthdate,
  }) async {
    emit(CreateUserLoadingState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        uid: value.user!.uid,
        username: username,
        phone: phone,
        password: password,
        fullName: fullName,
        birthdate: birthdate,
      );
      emit(CreateUserSuccessState(value.user!.uid));
    }).catchError((onError) {
      emit(CreateUserErrorState(onError.message.toString()));
      print(onError.toString());
    });
  }

  Future<void> userCreate({
    required String email,
    required String uid,
    required String username,
    required String phone,
    required String password,
    required String fullName,
    required String birthdate,
  }) async {
    UserDataModel model = UserDataModel(
      fullName: fullName,
      birthdate: birthdate,
      email: email,
      phone: phone,
      phoneVir: false,
      uId: uid,
      userName: username,
      image: 'https://img.freepik.com/free-photo/blue-user-icon-symbol-website-admin-social-login-element-concept-white-background-3d-rendering_56104-1217.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph',
    );
    print('user done');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap());
    print('donnnne');
  }

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(CreateUserUsingEmailLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(CreateUserUsingEmailSuccessState(value.user!.uid));
    }).catchError((onError) {
      emit(CreateUserUsingEmailErrorState(onError.message.toString()));
    });
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
