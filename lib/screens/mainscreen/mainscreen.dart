import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reefood/screens/favorites/favorite_page.dart';
import 'package:reefood/screens/me_tab/userprofile_page.dart';
import 'package:reefood/screens/home/home_screen.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/screens/home/widgets/businessList.dart';
import 'package:reefood/screens/mainscreen/fab.dart';

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
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final List<Widget> _bodyContent = [
    HomeScreen(),
    BusinessList(),
    UserFavorite(),
    ME()

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
      key: _scaffoldKey,
      body: Center(
        child: _bodyContent.elementAt(_selectedIndex),
      ),
  
      
      bottomNavigationBar: FABBottomAppBar(
        backgroundColor: Color.fromARGB(255, 239, 236, 237),
        color: Colors.grey,
        //centerItemText: "",
        selectedColor:scheme.primary,
        notchedShape: CircularNotchedRectangle(),
        iconSize: 20.0,
        onTabSelected: (index) {
          setState(() {
            
            _changeIndex(index);
          });

    
        },
        items: [
          // --------
          FABBottomAppBarItem(iconData: FontAwesomeIcons.home, text: 'Explore'),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.store, text: 'Browse'),
        

          FABBottomAppBarItem(
              iconData: FontAwesomeIcons.heart, text: 'Favorite'),
          FABBottomAppBarItem(
              iconData: FontAwesomeIcons.user, text: 'me'),
               
         
        ], height: 70,
      ),
      
      
    );
  }
}
