import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/models/appointment_model/appointment_model.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_cubit.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_state.dart';
import 'package:mostakbal/feature/appointment/view/screens/Booking-done.dart';
import 'package:mostakbal/feature/appointment/view/screens/booking-step1-screen.dart';
import 'package:mostakbal/feature/home_page/search_favourite/view/screens/search_screen.dart';

import '../../../../core/const/components/elevated_button.dart';
import '../../../../core/const/const.dart';

class BookingScreen1 extends StatelessWidget {
  const BookingScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppointmentCubit()
          ..getAppointment(context)
          ..getCancledAppointment(context)
          ..getCompleteAppointment(context);
      },
      child: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppointmentCubit.get(context);
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'الحجوزات',
                  style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconlyLight.arrow_right,
                    color: Colors.black87,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyLight.search,
                      color: ColorStyle().primaryColor,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(70),
                  child: buildTabBarItem(),
                ),
              ),
              body: TabBarView(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return buildPaddingOtherOffers(
                        context: context,
                        cubit: cubit,
                        appointmentModel:
                            cubit.appointmentDataSource.addAppoinment[index],
                        index: index,
                        state: state,
                      );
                    },
                    itemCount: cubit.appointmentDataSource.addAppoinment.length,
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return buildCompleteBooking(
                          context,
                          cubit.appointmentDataSource
                              .addAppoinmentCompleted[index]);
                    },
                    itemCount: cubit
                        .appointmentDataSource.addAppoinmentCompleted.length,
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return buildRemoveBooking(
                        context,
                        cubit.appointmentDataSource.addAppoinmentCancled[index],
                      );
                    },
                    itemCount:
                        cubit.appointmentDataSource.addAppoinmentCancled.length,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildPaddingOtherOffers({
    required BuildContext context,
    required AppointmentModel appointmentModel,
    required AppointmentCubit cubit,
    required AppointmentState state,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 110,
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.white,
          elevation: 1,
          surfaceTintColor: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    appointmentModel.hotialImage,
                    width: 71,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appointmentModel.hotialName,
                        style: FontStyle().textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            IconlyLight.calendar,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          Text(
                            appointmentModel.startDate as String,
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          Text(
                            ' - ',
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          Text(
                            appointmentModel.endDate,
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 23,
                        width: 53,
                        decoration: BoxDecoration(
                            color: Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'مدفوع',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.tajawal(
                              fontSize: 10,
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookingDone(
                            appointmentModel: appointmentModel,
                          );
                        }));
                      },
                      child: Material(
                        color: ColorStyle().primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'عرض الذكرة',
                            style: FontStyle().textStyle(
                              fontSize: 12,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        _showCustomDialog(
                          context: context,
                          model: appointmentModel,
                          cubit: cubit,
                          state: state,
                          index: index,
                        );
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            ' الغاء الرحلة',
                            style: FontStyle().textStyle(
                              fontSize: 12,
                              fontColor: Colors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildCompleteBooking(
      BuildContext context, AppointmentModel appointmentModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 110,
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.white,
          elevation: 1,
          surfaceTintColor: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    appointmentModel.hotialImage,
                    width: 71,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appointmentModel.hotialName,
                        style: FontStyle().textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            IconlyLight.calendar,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          Text(
                            appointmentModel.startDate,
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          Text(
                            ' - ',
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          Text(
                            appointmentModel.endDate,
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 23,
                        width: 93,
                        decoration: BoxDecoration(
                            color: Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'تم اكتمال الحجز',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.tajawal(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookingStep1Screen(
                            hotialName: appointmentModel.hotialName,
                            hotialImage: appointmentModel.hotialImage,
                          );
                        }));
                      },
                      child: Material(
                        color: ColorStyle().primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ' حجز مره اخري',
                            style: FontStyle().textStyle(
                              fontSize: 12,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildRemoveBooking(
      BuildContext context, AppointmentModel appointmentModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 110,
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.white,
          elevation: 1,
          surfaceTintColor: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    appointmentModel.hotialImage,
                    width: 71,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appointmentModel.hotialName,
                        style: FontStyle().textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            IconlyLight.calendar,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          Text(
                            appointmentModel.startDate,
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          Text(
                            ' - ',
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          Text(
                            appointmentModel.endDate,
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'تم الغاء الحجز',
                            style: GoogleFonts.tajawal(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookingStep1Screen(
                            hotialImage: appointmentModel.hotialImage,
                            hotialName: appointmentModel.hotialName,
                          );
                        }));
                      },
                      child: Material(
                        color: ColorStyle().primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ' اعادة الحجز',
                            style: FontStyle().textStyle(
                              fontSize: 12,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabBarItem() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24), // Creates border
        color: Color.fromRGBO(250, 250, 250, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: FontStyle().textStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            fontColor: ColorStyle().primaryColor,
          ),
          unselectedLabelStyle: FontStyle().textStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            fontColor: Colors.white,
          ),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(24), // Creates border
            color: Color(
              0xFF0D6EFD,
            ),
          ),
          isScrollable: true,
          tabs: [
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'الحالية',
                style: GoogleFonts.tajawal(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'المكتملة',
                style: GoogleFonts.tajawal(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'الملغية',
                style: GoogleFonts.tajawal(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomDialog({
    required BuildContext context,
    required AppointmentModel model,
    required AppointmentCubit cubit,
    required AppointmentState state,
    required int index,
  }) {
    if (state is AddCancledAppointmentSuccess) {
      AppointmentCubit().deleteAppointment(
        id: cubit.appointmentDataSource.ids[index],
      );
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 369,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/squeak-chat.appspot.com/o/photo_6003435162874002505_m.jpg?alt=media&token=ad94418d-c7b6-4904-9eae-e1a769e62ae0',
                    height: 150,
                  ),
                  Text(
                    'هل تريد بالفعل إلغاء الحجز ؟',
                    style: FontStyle().textStyle(
                        fontSize: 14,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromRGBO(250, 250, 250, 1),
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                          ),
                          child: Text(
                            'الغاء',
                            style: FontStyle().textStyle(
                              fontColor: ColorStyle().primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            cubit.addCancledAppointment(
                              model: model,
                              context: context,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,

                            backgroundColor: ColorStyle().primaryColor,
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                          ),
                          child: Text(
                            'نعم, متابعة',
                            style: FontStyle().textStyle(
                              fontSize: 14,
                              fontColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
