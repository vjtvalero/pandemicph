import 'package:flutter/material.dart';
import '../../src/theme.dart';
import '../../models/bulletin.dart';
import '../../models/country.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  String _selectedCountry = 'Philippines';
  List<dynamic> _flags = [];
  Bulletin bulletin = new Bulletin();
  Country countryModel = new Country();
  Future<Bulletin> futureBulletin;

  @override
  void initState() {
    super.initState();
    this._getFlags();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureBulletin = bulletin.fetchBulletin();
  }

  void _getFlags() async {
    final flags = await countryModel.initImages(context);
    setState(() {
      _flags = flags;
    });
  }

  void _onCountrySelected(country) {
    setState(() {
      _selectedCountry = country;
      futureBulletin = bulletin.fetchBulletin(
          country: countryModel.cleanseCountryName(country));
    });
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidth = MediaQuery.of(context).size.width / 2.5;
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<Bulletin>(
      future: futureBulletin,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Statistics',
                        style: titleStyle,
                      ),
                      Text(
                        'Per country',
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                  DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      value: _selectedCountry,
                      items: _flags.map((flag) {
                        return new DropdownMenuItem<String>(
                          value: flag['name'],
                          child: Container(
                            width: dropdownWidth,
                            child: ConstrainedBox(
                              constraints: new BoxConstraints(
                                maxHeight: 18.0,
                                maxWidth: dropdownWidth,
                              ),
                              child: FittedBox(
                                alignment: Alignment.centerRight,
                                fit: BoxFit.fitHeight,
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      width: 40.0,
                                      height: 20.0,
                                      image: AssetImage(
                                          'assets/images/country_flags/' +
                                              flag['filename']),
                                    ),
                                    Text(
                                      flag['name'],
                                      style: normalTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _onCountrySelected(value);
                      },
                    ),
                  ),
                ],
              ),
              bulletin.make(snapshot.data),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Center(
          child: Container(
            margin: EdgeInsets.only(
              top: screenHeight / 15,
            ),
            padding: const EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
