import 'package:flutter/material.dart';
import 'package:reefood/screens/UserProfileEdit/profile_main.dart';
import 'package:reefood/screens/auth/choose_location.dart';
import 'package:reefood/screens/home/home_screen.dart';
import 'package:reefood/colors.dart';
import 'package:reefood/screens/home/widgets/businessList.dart';
class MainScreenApp extends StatelessWidget {
  const MainScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      //theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static TextStyle labelStyle = TextStyle(
    color: Color.fromARGB(255, 7, 255, 222),
    fontSize: 12, // Adjust the font size as needed
  );

  static final List<Widget> _bodyContent = [
    HomeScreen(),
    BusinessList(),
    ChooseLocation(),
    EditProfilePage()
  
  
  
  ];

void _changeIndex(int index) {
  print(index);
  if (index >= 0 && index < _bodyContent.length) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _bodyContent.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: scheme.background,
          primaryColor: scheme.secondary,
          textTheme: Theme.of(context).textTheme.copyWith(
                bodySmall: labelStyle,
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _changeIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                color: scheme.secondary,
              ),
              label: "Discover",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: scheme.secondary,
              ),
              label: "Browse",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                color: scheme.secondary,
              ),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                color: scheme.secondary,
              ),
              label: "Me",
            ),
          ],
        ),
      ),
    );
  }
}
