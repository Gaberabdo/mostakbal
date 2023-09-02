import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/core/models/appointment_model/appointment_model.dart';
import 'package:mostakbal/core/models/auth_model/login_model.dart';
import 'package:mostakbal/feature/appointment/data_source/appointment_data_source.dart';

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

  ///todo get appointment
  Future<void> getAppointment(context) async {
    emit(GetAppointmentLoading());
    try {
      appointmentDataSource.getAppointment(context).then(
        (value) {
          emit(GetAppointmentSuccess());
          print('geeeeeeeeeeeeeeeeeeeeeeeeeeeeeet sucessssssssss');
        },
      );
    } catch (e, s) {
      print(s);
      emit(GetAppointmentError());
    }
  }

  ///todo get cancled appoinment
  void getCancledAppointment(context) {
    emit(GetAppointmentLoading());

    appointmentDataSource.getCancledAppointment(context);
    emit(GetAppointmentSuccess());
    print(
        'geeeeeeeeeeeeeeeeeeeeeeeeeeeeeet Cannnnnnnnnnnnnnncled sucessssssssss');

    emit(GetAppointmentError());
  }

  ///todo get complete appoinment
  Future<void> getCompleteAppointment(context) async {
    emit(GetAppointmentLoading());
    try {
      appointmentDataSource.getCompleteAppointment(context).then(
        (value) {
          emit(GetAppointmentSuccess());
          print(
              'geeeeeeeeeeeeeeeeeeeeeeeeeeeeeet completttttte sucessssssssss');
        },
      );
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
