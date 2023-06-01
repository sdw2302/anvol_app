import 'package:anvol_app/hr_page.dart';
import 'package:anvol_app/reports_page.dart';
import 'package:flutter/material.dart';
import './planning_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  bool loggedIn = false;

  final List<Widget> _pages = [
    const MainPageContent(),
    const PlanningPage(),
    const HRPage(),
    const ReportsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffB2CB06),
        title: const Text('Anvol App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              if (!loggedIn) {
                _showLoginDialog(context);
              } else {
                _showPersonalInfoPopup(context);
              }
            },
          )
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Planning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'HR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Reports',
          ),
        ],
        backgroundColor: const Color(0xffE7E7E7),
        selectedItemColor: const Color(0xffFFD30B),
        unselectedItemColor: Colors.grey,
      ),
      backgroundColor: Colors.white,
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Login'),
              onPressed: () {
                // Perform login logic

                // Once login is successful, close the dialog
                loggedIn = true;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPersonalInfoPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text('This is a notification!'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MainPageContent extends StatelessWidget {
  const MainPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Home page'),
        ],
      ),
    );
  }
}
