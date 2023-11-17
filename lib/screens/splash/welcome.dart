import 'package:flutter/material.dart';
import 'package:reefood/app_localizations.dart';
import 'package:reefood/screens/auth/main_auth.dart';
import 'package:reefood/screens/splash/items.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double currentPage = 0.0;
  final _pageViewController = new PageController();

  @override
  void initState() {
    super.initState();
    _pageViewController.addListener(() {
      setState(() {
        currentPage = _pageViewController.page!;
      });
    });
  }

  List<Map<String, dynamic>> getItems(BuildContext context) {
    return [
      {
        "header": AppLocalizations.of(context).translate('welcomeScreenTitle'),
        "description": AppLocalizations.of(context)
            .translate('welcomeScreenDescription'),
        "image": "assets/img/logo.png"
      },
      {
        "header": AppLocalizations.of(context).translate('feature1Header'),
        "description": AppLocalizations.of(context)
            .translate('feature1Description'),
        "image": "assets/img/hot_deal.png"
      },
      {
        "header": AppLocalizations.of(context).translate('feature2Header'),
        "description": AppLocalizations.of(context)
            .translate('feature2Description'),
        "image": "assets/img/partners.png"
      },
    ];
  }

  void _navigateToNext() {
    if (currentPage < getItems(context).length - 1) {
      _pageViewController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle navigation after the last page
      // For example, you can navigate to the home screen
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = getItems(context);

    List<Widget> slides = items
        .map((item) => Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Image.asset(
                      item['image'],
                      fit: BoxFit.fitWidth,
                      width: 220.0,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: <Widget>[
                          Text(item['header'],
                              style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0XFF3F3D56),
                                  height: 2.0)),
                          Text(
                            item['description'],
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1.2,
                                fontSize: 16.0,
                                height: 1.3),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
        .toList();

    List<Widget> indicator() => List<Widget>.generate(
          slides.length,
          (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
              color: currentPage.round() == index
                  ? Color(0XFF256075)
                  : Color(0XFF256075).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: slides.length,
              itemBuilder: (BuildContext context, int index) {
                return slides[index];
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 70.0),
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicator(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, '/auth');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen()));
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _navigateToNext,
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
