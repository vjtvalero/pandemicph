import 'package:flutter/material.dart';
import '../src/theme.dart';

class WidgetSpacer extends StatelessWidget {
  final String size;
  WidgetSpacer({this.size});

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case 'thin':
        return SizedBox(height: 5);
      case 'medium':
        return SizedBox(height: 10);
      default:
        return SizedBox(height: 20);
    }
  }
}

class TextDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 10);
  }
}

class DetailBox extends StatelessWidget {
  final String title;
  final Widget value;

  DetailBox({
    Key key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: subtitleStyle,
              ),
              TextDivider(),
              value
            ],
          ),
        ),
      ),
    );
  }
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class AppDialog {
  static void simple(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
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
