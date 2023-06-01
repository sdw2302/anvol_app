import 'package:flutter/material.dart';

class PlanningPage extends StatelessWidget {
  const PlanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Planning Page'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
