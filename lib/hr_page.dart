import 'package:flutter/material.dart';

class HRPage extends StatelessWidget {
  const HRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HR Page'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
