import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anvol App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const AnvolHomePage(title: 'Anvol App'),
    );
  }
}

class AnvolHomePage extends StatefulWidget {
  const AnvolHomePage({super.key, required this.title});
  final String title;

  @override
  State<AnvolHomePage> createState() => _AnvolHomePageState();
}

class _AnvolHomePageState extends State<AnvolHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB2CB06),
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'WIP',
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xffE7E7E7),
    );
  }
}
