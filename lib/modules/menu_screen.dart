import 'package:flutter/material.dart';
import 'package:pandemicph/modules/menu_screen/credit_screen.dart';
import 'package:pandemicph/src/theme.dart';
import 'package:pandemicph/src/widgets.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: <Widget>[
                MenuItem(
                  'Username',
                  'vjtvalero',
                  Icon(Icons.person_outline),
                  '',
                  true,
                ),
                MenuItem(
                  'Phone',
                  '+639396589057',
                  Icon(Icons.phone_iphone),
                  '',
                  true,
                ),
                MenuItem(
                  'Address',
                  '#29 Makaneneng St. Bagong Barrio, Caloocan City',
                  Icon(Icons.place),
                  '',
                  true,
                ),
                MenuItem(
                  'Help',
                  '',
                  Icon(Icons.help_outline),
                  '',
                  true,
                ),
                MenuItem(
                  'Credits',
                  '',
                  Icon(Icons.info_outline),
                  CreditScreen.routeName,
                  true,
                ),
                WidgetSpacer(),
                MenuItem(
                  'Logout',
                  '',
                  Icon(null),
                  '',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String leftText;
  final String rightText;
  final Icon icon;
  final String routeName;
  final bool hasRightIcon;
  MenuItem(
    this.leftText,
    this.rightText,
    this.icon,
    this.routeName,
    this.hasRightIcon,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          routeName,
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    icon,
                    SizedBox(width: 10),
                    Text(leftText, style: normalTextStyle),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 180,
                      child: Text(
                        rightText,
                        style: subtitleStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(hasRightIcon == true ? Icons.chevron_right : null,
                        color: mutedColor, size: 18)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
