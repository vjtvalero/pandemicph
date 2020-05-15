import 'package:flutter/material.dart';
import '../src/theme.dart';
import '../src/widgets.dart';
import '../modules/home_screen/statistics.dart';
import '../modules/home_screen/assistances.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: containerPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Assistances(),
          WidgetSpacer(),
          Statistics(),
        ],
      ),
    );
  }
}
