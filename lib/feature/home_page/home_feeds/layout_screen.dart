import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/core/local/cache_helper.dart';
import 'package:mostakbal/feature/authentication/controller/auth_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_state.dart';
import 'package:mostakbal/feature/profile-feature/controller/setting_cubit.dart';

import '../../authentication/data_source/auth_data_source.dart';
import '../../fav-feature/controller/fav_cubit.dart';
import '../../profile-feature/data_source/setting_data_source.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) {
            return HomeCubit()
              ..getBannar()
              ..getForYouData()
              ..getDomesticTourism()
              ..getForeignTourism()
              ..getHajjAndUmrah()
              ..getOffer();
          },
        ),
        BlocProvider(
          create: (context) {
            return SettingCubit()..getUserData();
          },
        ),
        BlocProvider(
          create: (context) {
            return FavCubit()..getToFav();
          },
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var settingCubit = SettingCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: buildCurvedNavigationBar(cubit),
            appBar: (SettingCubit.get(context).userDataModel != null)
                ? SettingCubit.get(context).userDataModel!.phoneVir == false
                    ? AppBar(
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 40,
                              child: Material(
                                color: Colors.yellow.shade50,
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    SettingCubit.get(context).verifyEmail().then(
                                      (value) {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(CacheHelper.getData(key: 'uId'))
                                            .update(
                                          {
                                            "phoneVir": true,
                                          },
                                        ).then(
                                          (value) {
                                            Fluttertoast.showToast(
                                              msg: "تم تفعيل الايميل",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );

                                            Navigator.pushAndRemoveUntil(
                                                context, MaterialPageRoute(
                                              builder: (context) {
                                                return HomeLayoutScreen();
                                              },
                                            ), (route) => false);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(IconlyLight.danger,
                                          color: Colors.black),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "pleas Confirm Email",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Spacer(),
                                      Icon(Icons.phone_android,
                                          color: Colors.black),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : null
                : null,
            body:cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }

  CurvedNavigationBar buildCurvedNavigationBar(HomeCubit cubit) {
    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 300),
      index: cubit.currentIndex,
      color: Colors.white,
      backgroundColor: Colors.white,
      buttonBackgroundColor: ColorStyle().primaryColor,
      height: 75,
      animationCurve: Curves.ease,
      items: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            IconlyLight.home,
            size: 24,
            color: cubit.currentIndex == 0 ? Colors.white : Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            IconlyLight.ticket,
            size: 24,
            color: cubit.currentIndex == 1 ? Colors.white : Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            IconlyLight.heart,
            size: 24,
            color: cubit.currentIndex == 2 ? Colors.white : Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            IconlyLight.profile,
            size: 24,
            color: cubit.currentIndex == 3 ? Colors.white : Colors.grey,
          ),
        ),
      ],
      onTap: (index) {
        cubit.changeBottom(index);
      },
    );
  }
}
