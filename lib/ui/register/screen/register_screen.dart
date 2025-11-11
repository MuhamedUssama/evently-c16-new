import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AppConstants.dart';
import 'package:evently_c16/core/resources/DialogUtils.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/reusable_components/CustomButton.dart';
import 'package:evently_c16/core/source/remote/FirestoreManager.dart';
import 'package:evently_c16/ui/register/screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:evently_c16/model/User.dart' as MyUser;
import '../../../core/resources/AssetsManager.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController rePasswordController;
  String selectedLanguage = "en";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManager.logo),
                  SizedBox(
                    height: 24,
                  ),
                  CustomField(
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name shouldn't be empty";
                        }
                      },
                      hint: "name".tr(),
                      prefix: AssetsManager.person,
                      controller: nameController
                  ),
                  SizedBox(height: 16,),
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
                  CustomField(
                    controller: rePasswordController,
                    validation: (value) {
                      if (value != passwordController.text) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    hint: "rePass".tr(),
                    prefix: AssetsManager.lock,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                      title: "createAcc".tr(),
                      onPress: () {
                        if (formKey.currentState?.validate() ?? false) {
                          print("Email : ${emailController.text}");
                          print("Password : ${passwordController.text}");
                          createAccount();
                        }
                      }),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("alreadyHaveAcc".tr(), style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesManager.register);
                        },
                        child: Text("login".tr(), style: Theme
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
      ),
    );
  }
  // autologin
  createAccount() async {
    try {
      DialogUtils.showLoadingDialog(context);
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      await FirestoreManager.addUser(MyUser.User(
        id:credential.user?.uid ,
        email: emailController.text,
        name: nameController.text
      ));

      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, RoutesManager.home, (route) => false);
      print("Done");
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        DialogUtils.showMessageDialog(context: context,
            message: 'The password provided is too weak.',
            positiveActionTitle: "Ok",
            positiveActionPress: (){
              Navigator.pop(context);
            });
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessageDialog(context: context,
            message: 'The account already exists for that email.',
            positiveActionTitle: "Ok",
            positiveActionPress: (){
              Navigator.pop(context);
            });
      }
    } catch (error) {
      Navigator.pop(context);
      DialogUtils.showMessageDialog(context: context,
          message: "No Interntet Connection",
          positiveActionTitle: "Ok",
          positiveActionPress: (){
            Navigator.pop(context);
          });
      print(error);
    }
  }

}
