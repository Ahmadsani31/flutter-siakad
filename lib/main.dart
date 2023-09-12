import 'package:flutter/material.dart';
import 'package:siakat/home.dart';
import 'package:siakat/screen/login/login.dart';
import 'dart:io';

import 'package:siakat/screen/login/register.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/register': (BuildContext context) => const RegisterPage(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
