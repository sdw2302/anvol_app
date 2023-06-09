import 'package:anvol_app/hr_page.dart';
import 'package:anvol_app/planning_page.dart';
import 'package:anvol_app/profile_page.dart';
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
        setUsername: _setUsername,
        setLoggedIn: _setLoggedIn,
      ),
      const PlanningPage(),
      const HRPage(),
      const ReportsPage(),
      const ProfilePage(),
    ];
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: loggedIn ? _buildBottomNavigationBar() : null,
      backgroundColor: Colors.white,
    );
  }

  void _setUsername(String name) {
    setState(() {
      username = name;
    });
  }

  void _setLoggedIn(bool state) {
    setState(() {
      loggedIn = state;
    });
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
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: 'Profile',
        ),
      ],
      backgroundColor: const Color(0xffE7E7E7),
      selectedItemColor: const Color(0xffFFD30B),
      unselectedItemColor: Colors.grey,
    );
  }
}

class MainPageContent extends StatefulWidget {
  final bool isLoggedIn;
  final String username;
  final Function(String) setUsername;
  final Function(bool) setLoggedIn;

  const MainPageContent(
      {Key? key,
      required this.isLoggedIn,
      required this.username,
      required this.setUsername,
      required this.setLoggedIn})
      : super(key: key);

  @override
  State<MainPageContent> createState() => _MainPageContentState();
}

class _MainPageContentState extends State<MainPageContent> {
  TextEditingController usernameController = TextEditingController();
  double screenWidth = 0;
  double textFieldWidth = 0;
  double paddingTopSize = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    textFieldWidth = screenWidth * 0.3;
    paddingTopSize = screenWidth * 0.02;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.isLoggedIn ? const Text("Home Page") : _buildLoginPage(),
    );
  }

  Column _buildLoginPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center,
          child: Title(
            color: Colors.black,
            child: const Text(
              "Anvol",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        SizedBox(
          width: textFieldWidth,
          child: TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
        ),
        SizedBox(
          width: textFieldWidth,
          child: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: paddingTopSize),
        ),
        TextButton(
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onPressed: () {
            // Perform login logic
            String username = usernameController.text;
            widget.setUsername(username);
            widget.setLoggedIn(true);
          },
        ),
      ],
    );
  }
}
