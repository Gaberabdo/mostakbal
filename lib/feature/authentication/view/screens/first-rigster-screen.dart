import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mostakbal/feature/authentication/controller/auth_cubit.dart';
import 'package:mostakbal/feature/authentication/data_source/auth_data_source.dart';
import 'package:mostakbal/feature/authentication/view/component/first-rigister-body.dart';
import 'package:mostakbal/feature/authentication/view/screens/register-screen1.dart';
import 'package:mostakbal/feature/authentication/view/screens/second-sign%20in-screen.dart';

class FirstRegisterScreen extends StatelessWidget {
  const FirstRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, index) {},
        builder: (context, index) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'انضم الى المستقبل الان',
                        style: GoogleFonts.tajawal(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 50),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          width: 85,
                          height: 89,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xFFE9F4FF),
                            borderRadius: BorderRadius.circular(12)),
                        child: MaterialButton(
                          onPressed: () async {
                            // cubit.signInWithGoogle();
                          },
                          child: Row(
                            children: [
                              Spacer(),
                              Logo(Logos.google, size: 22),
                              SizedBox(width: 15,),
                              const Text(
                                'اكمل باستخدام جوجل',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1977F3),
                            borderRadius: BorderRadius.circular(12)),
                        child: MaterialButton(
                          onPressed: () async {
                            // cubit.loginWithFacebook();
                          },
                          child: const Row(
                            children: [
                              Spacer(),

                              Icon(
                                Icons.facebook_outlined,
                                size: 26,
                                color: Colors.white,
                              ),
                              SizedBox(width: 15,),

                              Text(
                                'اكمل باستخدام فيسبوك',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(12)),
                        child: MaterialButton(
                          onPressed: () async {},
                          child: const Row(
                            children: [
                              Spacer(),

                              Icon(
                                Icons.apple_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20,),
                              Text(
                                'اكمل باستخدام أبل',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
                              child: const Divider(
                                color: Color(0xFFE6E6E6),
                                height: 50,
                              )),
                        ),
                        Text(
                          "او",
                          style: GoogleFonts.tajawal(
                              fontSize: 12, color: const Color(0xFF8F8996)),
                        ),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 10.0),
                              child: const Divider(
                                color: Color(0xFFE6E6E6),
                                height: 50,
                              )),
                        ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1977F3),
                            borderRadius: BorderRadius.circular(16)),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SecondSignInScreen();
                            }));
                          },
                          child: const Text(
                            'الدخول باستخدام كلمه المرور',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'لاتمتلك حساب ؟',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterScreen();
                                }));
                              },
                              child: const Text(
                                'انشاء حساب',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.blue),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
