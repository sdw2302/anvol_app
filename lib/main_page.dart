import 'package:anvol_app/planning_page.dart';
import 'package:anvol_app/hr_page.dart';
import 'package:anvol_app/reports_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  bool loggedIn = false;
  String username = '';

  List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    _pages = [
      MainPageContent(
        isLoggedIn: loggedIn,
        username: username,
      ),
      const PlanningPage(),
      const HRPage(),
      const ReportsPage(),
    ];
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
      bottomNavigationBar: loggedIn ? _buildBottomNavigationBar() : null,
      backgroundColor: Colors.white,
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }

  void _showLoginDialog(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Welcome!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                // Perform login logic

                // Once login is successful, close the dialog
                setState(() {
                  username = usernameController.text;
                  loggedIn = true;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
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
          title: Text('Hi, $username'),
          content: const Text('This is a test!'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  loggedIn = false;
                  username = '';
                  _currentIndex = 0;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

class MainPageContent extends StatefulWidget {
  final bool isLoggedIn;
  final String username;

  const MainPageContent(
      {Key? key, required this.isLoggedIn, required this.username})
      : super(key: key);

  @override
  State<MainPageContent> createState() => _MainPageContentState();
}

class _MainPageContentState extends State<MainPageContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.isLoggedIn ? 'Home page' : 'Please log in',
          ),
        ],
      ),
    );
  }
}
