import 'package:flutter/material.dart';
import 'package:pandemicph/modules/menu_screen/credit_screen.dart';
import 'package:pandemicph/src/widgets.dart';
import 'src/strings.dart';
import 'src/theme.dart';
import 'package:pandemicph/modules/navbar.dart';
import 'package:pandemicph/modules/home_screen.dart';
import 'package:pandemicph/modules/tracker_screen.dart';
import 'package:pandemicph/modules/menu_screen.dart';
import 'package:pandemicph/modules/home_screen/claim_screen.dart';

class AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: appTitle);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;

  void _changePage(index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<Map> _pages = [
    {'name': 'HomeScreen', 'widget': HomeScreen(), 'isDedicated': false},
    {'name': 'TrackerScreen', 'widget': TrackerScreen(), 'isDedicated': true},
    {'name': 'MenuScreen', 'widget': MenuScreen(), 'isDedicated': false},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: makeDefaultTheme(context),
      onGenerateRoute: (settings) { // routes that need the SlideLeft
        Route page;
        switch (settings.name) {
          case CreditScreen.routeName:
            page = SlideLeftRoute(page: CreditScreen());
            break;
        }
        return page;
      },
      routes: { // normal routes
        ClaimScreen.routeName: (context) => ClaimScreen(),
      },
      home: Scaffold(
        backgroundColor: bgColor,
        appBar: _pages[_currentPage]['isDedicated'] == true
            ? null
            : AppBar(
                title: Text(
                  widget.title,
                  style: pageTitleStyle,
                ),
                centerTitle: true,
                backgroundColor: bgColor,
                elevation: 0,
              ),
        body: _pages[_currentPage]['isDedicated'] == true
            ? _pages[_currentPage]['widget']
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: _pages[_currentPage]['widget'],
              ),
        bottomNavigationBar: NavBar(
          _changePage,
          _currentPage,
        ),
      ),
    );
  }
}
