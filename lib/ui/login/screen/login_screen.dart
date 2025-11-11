import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AppConstants.dart';
import 'package:evently_c16/core/resources/DialogUtils.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/reusable_components/CustomButton.dart';
import 'package:evently_c16/ui/register/screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String selectedLanguage = "en";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AssetsManager.logo),
                SizedBox(
                  height: 24,
                ),
                CustomField(
                  hint: "email".tr(),
                  prefix: AssetsManager.email,
                  controller: emailController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email shouldn't be empty";
                    }
                    var regex = RegExp(emailRegex);
                    if (!regex.hasMatch(value)) {
                      return "Email isn't valid";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                CustomField(
                  controller: passwordController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password shouldn't be empty";
                    }
                    if (value.length < 8) {
                      return "Password shouldn't be less than 8";
                    }
                    return null;
                  },
                  hint: "pass".tr(),
                  prefix: AssetsManager.lock,
                  isPassword: true,
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "forgotPass".tr(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      )),
                ),
                SizedBox(
                  height: 24,
                ),
                CustomButton(
                    title: "login".tr(),
                    onPress: () {
                      if (formKey.currentState?.validate() ?? false) {
                        signin();
                      }
                    }),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("dontHaveAccount".tr(), style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesManager.register);
                      },
                      child: Text("createAcc".tr(), style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                          fontWeight: FontWeight.w500
                      ),),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                CustomSwitch(
                    selected: selectedLanguage,
                    icon2: AssetsManager.eg,
                    icon1: AssetsManager.us,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                      if (selectedLanguage == "ar") {
                        context.setLocale(Locale("ar"));
                      } else {
                        context.setLocale(Locale("en"));
                      }
                    },
                    values: ["en", "ar"]
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  signin() async {
    try {
      DialogUtils.showLoadingDialog(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, RoutesManager.home);
      print(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showMessageDialog(
            context: context,
            message: 'No user found for that email.',
            positiveActionTitle: "Ok",
            positiveActionPress: (){
              Navigator.pop(context);
            });
      } else if (e.code == 'wrong-password') {
        DialogUtils.showMessageDialog(
            context: context,
            message: 'Wrong password provided for that user.',
            positiveActionTitle: "Ok",
            positiveActionPress: (){
              Navigator.pop(context);
            });
      }
    } catch (e) {
      Navigator.pop(context);
      DialogUtils.showMessageDialog(
          context: context,
          message: "No Internet Connection",
          positiveActionTitle: "Ok",
          positiveActionPress: (){
            Navigator.pop(context);
          });
    }
  }
}
