import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/core/local/applocal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/local/cache_helper.dart';
import 'core/observer/observer.dart';
import 'feature/authentication/view/screens/first-rigster-screen.dart';
import 'feature/home_page/home_feeds/layout_screen.dart';
import 'feature/home_page/home_feeds/view/screens/onboarding/view/screens/onboarding_screen.dart';
import 'package:flutter/services.dart';

String uId = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = await MyBlocObserver();
  await CacheHelper.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true),
  );

  Widget widget = OnBoardingScreen();

  bool isOnboarding = CacheHelper.getData(key: 'isOnboarding') ?? false;


  print(isOnboarding);
  uId = CacheHelper.getData(key: 'uId') ?? '';
  if (isOnboarding) {
    if (uId == '') {
      widget = const FirstRegisterScreen();
    } else {
      widget = const HomeLayoutScreen();
    }
  }

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.startWidget});
  Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("ar", ""),
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: ColorStyle().primaryColor,
            scaffoldBackgroundColor: Colors.white,
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorStyle().primaryColor),
            useMaterial3: true,
          ),
          home: startWidget,
        );
      },
    );
  }
}
