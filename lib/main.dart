// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'models/user.dart';
import 'services/authentication.dart';
import 'services/database.dart';
import 'templates/splashscreen_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBrB6t191XogodYEtT_sCoKflfKzDRBWuY",
          authDomain: "lira-1a32f.firebaseapp.com",
          projectId: "lira-1a32f",
          storageBucket: "lira-1a32f.appspot.com",
          messagingSenderId: "524526892618",
          appId: "1:524526892618:web:22e02657ce20aec71a58b3",
          measurementId: "G-CWKDFV8X1G"));

  Gemini.init(
      apiKey: "AIzaSyCbpZUoYxTeuN9puw-jnjjVx1jbkNnVbpg", enableDebugging: true);

  runApp(
    MultiProvider(providers: [
      Provider<AppUserData>(create: (_) => AppUserData()),
      StreamProvider<List<AppUserData>>.value(
          initialData: const [], value: DatabaseService().users),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return StreamProvider<AppUser?>.value(
          initialData: null,
          value: AuthenticationService().user,
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'Veebble AI',
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.unknown
                },
              ),
              theme: ThemeData.light().copyWith(
                  scrollbarTheme: const ScrollbarThemeData().copyWith(
                thumbColor: MaterialStateProperty.all(Colors.white),
              )),
              debugShowCheckedModeBanner: false,
              home: KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return const SplashScreenWrapper();
                },
              ),
            );
          });
    });
  }
}
