import 'package:anvol_app/hr_page.dart';
import 'package:anvol_app/planning_page.dart';
import 'package:anvol_app/reports_page.dart';
import 'package:flutter/material.dart';
import 'package:anvol_app/db_handler.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  int _lstIndex = 0;
  bool loggedIn = false;
  String username = '';

  List<Widget> _pages = [];

  double screenWidth = 0;
  double rowWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    rowWidth = screenWidth * 0.05;
  }

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
      const ReportsPage()
    ];

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      body: isLandscape
          ? _buildLandscapeBody(loggedIn)
          : _currentIndex < 4
              ? _pages[_currentIndex]
              : _pages[_lstIndex],
      bottomNavigationBar:
          loggedIn && !isLandscape ? _buildBottomNavigationBar() : null,
      backgroundColor: Colors.white,
    );
  }

  Widget _buildLandscapeBody(bool isLoggedIn) {
    return Row(
      children: [
        SizedBox(
          width: isLoggedIn ? rowWidth : 0,
          child: isLoggedIn ? _buildNavigationRail() : null,
        ),
        Expanded(
          child: _currentIndex < 4 ? _pages[_currentIndex] : _pages[_lstIndex],
        ),
      ],
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

  NavigationRail _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _currentIndex,
      onDestinationSelected: (int index) {
        setState(() {
          if (index == 4) {
            setState(() {
              _lstIndex = _currentIndex;
              _currentIndex = index;
            });
            _ifLoggedChecker();
          } else {
            _currentIndex = index;
          }
        });
      },
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.calendar_today_rounded),
          label: Text('Planning'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.people),
          label: Text('HR'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.analytics),
          label: Text('Reports'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text('Profile'),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          if (index == 4) {
            setState(() {
              _lstIndex = _currentIndex;
              _currentIndex = index;
            });
            _ifLoggedChecker();
          } else {
            _currentIndex = index;
          }
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
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      backgroundColor: const Color(0xffE7E7E7),
      selectedItemColor: const Color(0xffFFD30B),
      unselectedItemColor: Colors.grey,
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

  void _ifLoggedChecker() {
    if (!loggedIn) {
      _showLoginDialog(context);
    } else {
      _showPersonalInfoPopup(context);
    }
  }

  void _showPersonalInfoPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account'),
          content: Text('Hi ${username}'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Log out'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  loggedIn = false;
                  _currentIndex = 0;
                  username = "";
                });
              },
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
  final Function(String) setUsername;
  final Function(bool) setLoggedIn;

  const MainPageContent({
    Key? key,
    required this.isLoggedIn,
    required this.username,
    required this.setUsername,
    required this.setLoggedIn,
  }) : super(key: key);

  @override
  State<MainPageContent> createState() => _MainPageContentState();
}

class _MainPageContentState extends State<MainPageContent> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
    return Scaffold(
      body: widget.isLoggedIn ? _buildHomePage() : _buildLoginPage(),
    );
  }

  Padding _buildHomePage() {
    String username = widget.username;
    double padding = screenWidth * 0.01;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          Text(
            "Hi, $username",
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Center _buildLoginPage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Title(
              color: Colors.black,
              child: const Text(
                "XS",
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
              controller: passwordController,
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
              usernameController.clear();
              passwordController.clear();
            },
          ),
        ],
      ),
    );
  }
}
