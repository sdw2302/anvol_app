import 'package:flutter/material.dart';

import './main_page.dart';
import './planning_page.dart';
import './hr_page.dart';
import './reports_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anvol App',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xffB2CB06),
          onPrimary: Colors.white,
          secondary: Color(0xff80B845),
          onSecondary: Colors.white,
          error: Color(0xffE41600),
          onError: Colors.white,
          surface: Color(0xffE7E7E7),
          onSurface: Colors.black,
          background: Colors.white,
          onBackground: Colors.black,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/': (context) => const MainPage(),
        '/planning_page/': (context) => const PlanningPage(),
        '/hr_page/': (context) => const HRPage(),
        '/reports_page/': (context) => const ReportsPage(),
      },
      initialRoute: '/',
    );
  }
}
