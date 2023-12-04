import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/core/models/appointment_model/appointment_model.dart';
import 'package:mostakbal/core/models/auth_model/login_model.dart';
import 'package:mostakbal/feature/appointment/data_source/appointment_data_source.dart';

import '../../../main.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());

  static AppointmentCubit get(context) => BlocProvider.of(context);

  AppointmentDataSource appointmentDataSource = AppointmentDataSource();

  ///todo add appointment
  Future<void> addAppointment({
    required AppointmentModel model,
    required BuildContext context,
  }) async {
    emit(AddAppointmentLoading());
    try {
      appointmentDataSource.addAppointment(
        model: model,
        context: context,
      );

//SettingCubit.get(context).homeDataSource.userDataModel!.email,
      emit(AddAppointmentSuccess());
      print('apppppppppppppppppppppppppppppint done');
    } catch (e, s) {
      emit(AddAppointmentError());
      print(s);
    }
  }

  // add cancled appoinment
  Future<void> addCancledAppointment({
    required AppointmentModel model,
    required BuildContext context,
  }) async {
    emit(AddCancledAppointmentLoading());
    try {
      appointmentDataSource.addCancledAppointment(
        model: model,
        context: context,
      );

//SettingCubit.get(context).homeDataSource.userDataModel!.email,
      emit(AddCancledAppointmentSuccess());
      print('apppppppppppppppppppppppppppppint done');
    } catch (e, s) {
      emit(AddCancledAppointmentError());
      print(s);
    }
  }

  ///todo add complete

  Future<void> addCompleteAppointment({
    required AppointmentModel model,
    required BuildContext context,
  }) async {
    emit(AddCompleteAppointmentLoading());
    try {
      appointmentDataSource.addCompleteAppointment(
        model: model,
        context: context,
      );

//SettingCubit.get(context).homeDataSource.userDataModel!.email,
      emit(AddCompleteAppointmentSuccess());
      print('apppppppppppppppppppppppppppppintcompleeeeeeeeeeete done');
    } catch (e, s) {
      emit(AddCompleteAppointmentError());
      print(s);
    }
  }

  List<AppointmentModel> addAppoinment = [];
  List<AppointmentModel> addAppoinmentCancled = [];
  List<AppointmentModel> addAppoinmentCompleted = [];
  List<String> ids = [];

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///todo get appointment
  Future<void> getAppointment(context) async {
    emit(GetAppointmentLoading());
    try {
      fireStore
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
        emit(GetAppointmentSuccess());
      });
    } catch (e, s) {
      print(s);
      emit(GetAppointmentError());
    }
  }

  ///todo get cancled appoinment
  void getCancledAppointment(context) {
    emit(GetAppointmentLoading());
    fireStore
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
      emit(GetAppointmentSuccess());
    }).onError((handleError) {
      emit(GetAppointmentError());
    });
  }

  ///todo get complete appoinment
  Future<void> getCompleteAppointment(context) async {
    emit(GetAppointmentLoading());
    try {
      fireStore
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
        emit(GetAppointmentSuccess());
      });
    } catch (e, s) {
      print(s);
      emit(GetAppointmentError());
    }
  }

  ///todo delete appointment

  Future<void> deleteAppointment({required String id}) async {
    emit(DeleteAppointmentLoading());
    try {
      appointmentDataSource.deleteAppointment(id: id);
      emit(DeleteAppointmentSuccess());
      print('deeeeeeeeeeeeeeeeeeeeelte');
    } catch (e, s) {
      emit(DeleteAppointmentError());
      print(s);
    }
  }
}
