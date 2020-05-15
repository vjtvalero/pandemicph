import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pandemicph/models/assistance.dart';
import 'package:pandemicph/src/theme.dart';
import 'package:pandemicph/src/widgets.dart';

class ClaimScreen extends StatefulWidget {
  static const routeName = '/claim';

  @override
  _ClaimScreenState createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  List<bool> _isSelected = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String _locationDefault = 'Location not found';
  String _userLoc = _locationDefault;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final Assistance args = ModalRoute.of(context).settings.arguments;

    setState(() {
      args.requirements
          .asMap()
          .forEach((index, value) => _isSelected.add(false));
    });

    void _checkRequirements(index, value) {
      setState(() {
        _isSelected[index] = value;
      });
    }

    void _updateUserLoc(newUserLoc) {
      setState(() {
        _userLoc = newUserLoc;
      });
    }

    void _refreshLoc() async {
      final SharedPreferences prefs = await _prefs;
      List<String> userLoc = prefs.getStringList('userLatLng');
      if (userLoc != null && userLoc.isNotEmpty) {
        final coords =
            new Coordinates(double.parse(userLoc[0]), double.parse(userLoc[1]));
        final addresses =
            await Geocoder.local.findAddressesFromCoordinates(coords);
        _updateUserLoc(addresses.first.addressLine);
      }
    }

    void _submitCallout() {
      setState(() {
        _isSubmitting = true;
      });

      Future.delayed(
        Duration(seconds: 2),
        () => () {
          setState(() {
            _isSubmitting = false;
          });
        }(),
      );
    }

    Function _validateForm() {
      // if form is valid, enable button
      return _isSelected.where((item) => item == true).length ==
                  args.requirements.length &&
              _userLoc != _locationDefault &&
              !_isSubmitting
          ? () {
              _submitCallout();
            }
          : null;
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: BackButton(
          color: primaryColor,
        ),
        title: Text(
          args.name + ' (' + args.provider + ')',
          style: pageTitleStyle,
        ),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Container(
        padding: containerPadding,
        child: ListView(
          children: <Widget>[
            Text('Some info about the selected assistance.'),
            WidgetSpacer(),
            Text(
              'Requirements',
              style: titleStyle,
            ),
            Text(
              'If you think you qualify to all the requirements below, fill-up the call-out form.',
              style: subtitleStyle,
            ),
            WidgetSpacer(size: 'thin'),
            ListView.builder(
              itemCount: args.requirements.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  activeColor: successColor,
                  value: _isSelected[index],
                  onChanged: (bool newValue) {
                    _checkRequirements(index, newValue);
                  },
                  title: Text(args.requirements[index]),
                );
              },
            ),
            WidgetSpacer(size: 'medium'),
            GestureDetector(
              onTap: () {
                _refreshLoc();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Location', style: titleStyle),
                  Text(
                    'Click here to refresh location',
                    style: subtitleStyle,
                  ),
                  WidgetSpacer(),
                  Text(_userLoc),
                ],
              ),
            ),
            WidgetSpacer(),
            ButtonTheme(
              height: 45,
              minWidth: double.infinity,
              child: RaisedButton(
                onPressed: _validateForm(),
                child: Text('SUBMIT CALL-OUT'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: buttonPrimary,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
