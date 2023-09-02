import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/core/models/appointment_model/appointment_model.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_cubit.dart';

import '../../../core/models/auth_model/login_model.dart';
import '../../profile-feature/controller/setting_cubit.dart';

class AppointmentDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uId = FirebaseAuth.instance.currentUser!.uid;

  ///todo add appointment
  Future<void> addAppointment({
    required AppointmentModel model,
    required BuildContext context,
  }) async {
    firestore
        .collection('users')
        .doc(uId)
        .collection('appointment')
        .add(model.toMap());
  }

  //complet appointment
  Future<void> addCompleteAppointment({
    required AppointmentModel model,
    required BuildContext context,
  }) async {
    firestore
        .collection('users')
        .doc(uId)
        .collection('compeleteappointment')
        .add(model.toMap());
  }
  //cansled appoinment

  Future<void> addCancledAppointment({
    required AppointmentModel model,
    required BuildContext context,
  }) async {
    firestore
        .collection('users')
        .doc(uId)
        .collection('cancledappointment')
        .add(model.toMap());
  }

  ///todo get appointment
  List<AppointmentModel> addAppoinment = [];
  List<AppointmentModel> addAppoinmentCancled = [];
  List<AppointmentModel> addAppoinmentCompleted = [];
  List<String> ids = [];

  Future<void> getAppointment(context) async {
    final result = await firestore
        .collection('users')
        .doc(uId)
        .collection('appointment')
        .snapshots()
        .listen((value) {
      addAppoinment = [];
      for (var element in value.docs) {
        addAppoinment.add(AppointmentModel.fromJson(element.data()));
        ids.add(element.id);
        print(element.data());
      }
    });
    print('reeeeeeeeeeeeeeeeeeeeeeslut');
    print(result);
  }

  Future<void> getCompleteAppointment(context) async {
    final result = await firestore
        .collection('users')
        .doc(uId)
        .collection('compeleteappointment')
        .snapshots()
        .listen((value) {
      addAppoinmentCompleted = [];
      for (var element in value.docs) {
        addAppoinmentCompleted.add(AppointmentModel.fromJson(element.data()));
        print('commmmmmmmmmmmmplete getttttttttttttttttt');

        print(element.data());
      }
    });
    print('reeeeeeeeeeeeeeeeeeeeeeslut');
    print(result);
  }

  void getCancledAppointment(context) {
    final result = firestore
        .collection('users')
        .doc(uId)
        .collection('cancledappointment')
        .snapshots()
        .listen((value) {
      addAppoinmentCancled = [];
      for (var element in value.docs) {
        addAppoinmentCancled.add(AppointmentModel.fromJson(element.data()));

        print(element.data());
      }
    });
    print('reeeeeeeeeeeeeeeeeeeeeeslut');
    print(result);
  }

  // delettttte
  Future<void> deleteAppointment({required String id}) async {
    final result = await firestore
        .collection('users')
        .doc(uId)
        .collection('appointment')
        .doc(id)
        .delete()
        .then((value) {})
        .catchError((error) {});
  }

  ///todo delete appointment
  // Future<void> deleteAppointment({required String id}) async {
  //   firestore
  //       .collection('users')
  //       .doc(uId)
  //       .collection('appointment')
  //       .doc(id)
  //       .get();
  // }

  ///todo update appointment
  // Future<void> updateAppointment({
  //   required String fullName,
  //   required String email,
  //   required String phone,
  //   required String birthdate,
  //   required String userName,
  //   required String hotialImage,
  //   required String hotialName,
  //   required int numOfAdults,
  //   required int numOfYoung,
  //   required DateTime endDate,
  //   required DateTime startDate,
  //   required String id,
  // }) async {
  //   AppointmentModel appointmentModel = AppointmentModel(
  //     fullName: fullName,
  //     hotialName: hotialName,
  //     hotialImage: hotialImage,
  //     email: email,
  //     phone: phone,
  //     birthdate: birthdate,
  //     userName: userName,
  //     numOfAdults: numOfAdults,
  //     numOfYoung: numOfYoung,
  //     endDate: endDate.toString(),
  //     startDate: startDate.toString(),
  //   );
  //   firestore
  //       .collection('users')
  //       .doc(uId)
  //       .collection('appointment').doc(id)
  //       .update(appointmentModel.toMap());
  // }
}
