import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/auth_view.dart';
import 'package:hwee_tawseel_driver/views/auth/forget_password_view.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/verficode.dart';
import 'package:hwee_tawseel_driver/views/main/main_view.dart';
import 'package:hwee_tawseel_driver/views/myOrders/widgets/mapDetails.dart';
import 'package:hwee_tawseel_driver/views/notifcat/notificat.dart';
import 'package:hwee_tawseel_driver/views/onboarding/onboarding_view.dart';
import 'package:hwee_tawseel_driver/views/splash/splash_view.dart';
import 'package:provider/provider.dart';
import 'components/app_colors.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constant.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //for firbase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('language');
  await Hive.openBox('token');
  await Hive.openBox('name');
  await Hive.openBox('image');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late Box tokenbox = Hive.box("token");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Control();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          primaryColor: AppColors.textPrimary,
          scaffoldBackgroundColor: AppColors.white,
        ),
        routes: {
          "auth": (context) => AuthView(),
          "board": (context) => OnboardingView1(),
          'ForgetPasswordView': (context) => ForgetPasswordView(),
          'VerfiCode': (context) => VerfiCode(),
          'notificat': (context) => NotificationsView(),
          'MapDetails': (context) => MapDetails(),
        },
        home: SplashView(),
      ),
    );
  }
}
