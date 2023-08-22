import 'package:flutter/material.dart';
import 'package:mvvmbasic/utils/global_variables.dart';
import 'package:mvvmbasic/utils/routes.dart';
import '../providers/local_providers/app_local_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      navigatorKey.currentState!.pushNamed(AppRoutes.HOMESCREEN.name);
    });
  }

  Widget build(BuildContext context) {

    return AppLocalProviders(
      child: (context, localProvider, snapshot) {
        if (!localProvider.isload) {
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(
              "assets/images/logo.png",
              scale:2.6,
            ),
          ),
        );
      },
    );
  }
}

