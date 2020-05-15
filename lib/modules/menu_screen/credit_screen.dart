import 'package:flutter/material.dart';
import 'package:pandemicph/src/theme.dart';

class CreditScreen extends StatelessWidget {
  static const routeName = '/credits';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: BackButton(
          color: primaryColor,
        ),
        title: Text(
          'Credits',
          style: pageTitleStyle,
        ),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Container(
        padding: containerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> ' +
                  'from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>',
            ),
          ],
        ),
      ),
    );
  }
}
