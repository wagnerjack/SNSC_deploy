// This is the main file
// acts as a link to other pages and files

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snsc/config/pallete.dart';
import 'Pages/all_pages.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'models/user.dart';

Widget defaultLandingPage = const LandingPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('first_run') ?? true) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
    prefs.setBool('first_run', false);
  }

  bool doesUserExist = prefs.containsKey('user');

  if (doesUserExist) {
    String userStringInfo = prefs.getString('user')!;
    Map<String, dynamic> userMap = jsonDecode(userStringInfo);
    User user = User.fromJson(userMap);

    if (user.isAdmin!) {
      defaultLandingPage = const AdminLandingPage();
    } else {
      defaultLandingPage = const HomePage(
        email: '',
        password: '',
        wantsBiometrics: false,
      );
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              breakpoints: const [
                ResponsiveBreakpoint.resize(350, name: MOBILE),
                ResponsiveBreakpoint.resize(600, name: TABLET),
                ResponsiveBreakpoint.resize(750, name: DESKTOP),
                ResponsiveBreakpoint.resize(1350, name: 'XL'),
              ],
            ),
        title: 'SNSC App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Pallete.background,
        ),
        home: defaultLandingPage);
  }
}
