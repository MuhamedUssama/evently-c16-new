import 'package:evently_c16/core/resources/AssetsManager.dart';
import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AssetsManager.logo))
          .animate(
        onComplete: (controller) {
          if(FirebaseAuth.instance.currentUser!=null){
            Navigator.pushReplacementNamed(context, RoutesManager.home);
          }else{
            Navigator.pushReplacementNamed(context, RoutesManager.login);

          }
        },
      )
          .slideX(duration: Duration(seconds: 1))
          .then()
          .scale(duration: Duration(seconds: 2),
          begin: Offset(0.5, 0.5)),
    );
  }
}
