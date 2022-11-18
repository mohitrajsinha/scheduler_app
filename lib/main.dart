import 'package:android_app/api/sheets/user_sheets_api.dart';
import 'package:android_app/pages/home_page.dart';
import 'package:android_app/pages/login_page.dart';

import 'package:android_app/pages/signup_page.dart';
import 'package:android_app/utils/routes.dart';
import 'package:android_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyTheme.LightTheme(context),
        darkTheme: MyTheme.DarkTheme(context),
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          "/": ((context) => LoginPage()),
          MyRoutes.homeRoute: (context) => HomePage(),
          MyRoutes.loginRoute: (context) => LoginPage(),
          MyRoutes.signupRoute: (context) => SignUpPage(),
        });
  }
}
