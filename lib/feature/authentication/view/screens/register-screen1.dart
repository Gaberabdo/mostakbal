import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mostakbal/core/const/components/elevated_button.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/authentication/controller/auth_cubit.dart';
import 'package:mostakbal/feature/authentication/view/screens/rigster-screen2.dart';
import 'package:mostakbal/feature/authentication/view/screens/second-sign%20in-screen.dart';

import '../../../../core/local/cache_helper.dart';
import '../../../../main.dart';
import '../../../home_page/home_feeds/layout_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uid);
            uId = state.uid;
            print(uId);
            print(state.uid);
            RoutePage().navigateAndRemove(
              context,
              HomeLayoutScreen(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      ' انشاء حساب جديد',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: FontStyle().textStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormWidget(
                    icon: false,
                    emailController: emailController,
                    hintText: 'البريد الاكتروني',
                    prefixIcon: const Icon(
                      IconlyLight.message,
                    ),
                    validator: 'من فضلك ادخل البريد الاكتروني',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormWidget(
                    icon: true,
                    emailController: passwordController,
                    hintText: 'كلمه المرور',
                    prefixIcon: const Icon(
                      IconlyLight.lock,
                    ),
                    validator: 'من فضلك ادخل الباسورد',
                    obscureText: true,
                    suffixIcon: const Icon(
                      IconlyLight.show,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'من خلال ذلك فانك توافق علي الشروط والاحكام الخاصه بنا.',
                      style: GoogleFonts.tajawal(fontSize: 14),
                    ),
                    leading: Radio(
                      value: 12,
                      groupValue: false,
                      onChanged: (value) {
                        print("Button value: $value");
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorStyle().primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: MaterialButton(
                      onPressed: () {
                        print(passwordController.text);
                        print(emailController.text);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterScreen2(
                            password: passwordController.text,
                            emailcontroller: emailController,
                          );
                        }));
                      },
                      child: Text(
                        ' انشاء حساب',
                        style: FontStyle().textStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: const Divider(
                            color: Colors.grey,
                            height: 50,
                          )),
                    ),
                    const Text(
                      "او اكمل باستخدام",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: const Divider(
                            color: Colors.grey,
                            height: 50,
                          )),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 43,
                          width: 43,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            Icons.apple_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                  color: Color(0xFFE9F4FF),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Image.network(
                                  'http://pngimg.com/uploads/google/google_PNG19635.png',
                                  fit: BoxFit.cover))),
                      const SizedBox(
                        width: 30,
                      ),
                      (state is! CreateUserLoadingState) ?
                      InkWell(
                          onTap: () {},
                          child: Container(
                            height: 43,
                            width: 43,
                            decoration: BoxDecoration(
                                color: Color(0xFF4460A0),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: FaIcon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.white,
                            )),
                          )) : Center(child: CircularProgressIndicator(),),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '  تمتلك حساب بالفعل ؟',
                        style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SecondSignInScreen();
                            }));
                          },
                          child: Text(
                            ' تسجيل دخول',
                            style: GoogleFonts.tajawal(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blue),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
