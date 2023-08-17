import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/models/auth_model/login_model.dart';

class AuthDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> userRegister({
    required String email,
    required String username,
    required String phone,
    required String password,
    required String fullName,
    required String birthdate,
  }) async {
    auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then(
      (value) {
        userCreate(
          email: email,
          uid: value.user!.uid,
          username: username,
          phone: phone,
          password: password,
          birthdate: birthdate,
          fullName:fullName ,
        );
      },
    );
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
      fullName:fullName ,
      birthdate: birthdate,
      email: email,
      phone: phone,
      uId: uid,
      userName: username,
      image: 'https://img.freepik.com/free-photo/blue-user-icon-symbol-website-admin-social-login-element-concept-white-background-3d-rendering_56104-1217.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph',
    );

    await firestore.collection('users').doc(uid).set(model.toMap());
  }




}
