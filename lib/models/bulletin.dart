import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../src/widgets.dart';
import '../src/theme.dart';

class Bulletin {
  final String subject;
  final statistics;
  final String day;
  final String time;

  Bulletin({this.subject, this.statistics, this.day, this.time});

  factory Bulletin.fromJson(Map<String, dynamic> json) {
    if (json['results'] == 1 && json['response'].length > 0) {
      final data = json['response'][0];

      return Bulletin(
        statistics: {
          'cases': {
            'new': data['cases']['new'] ?? 0,
            'active': data['cases']['active'] ?? 0,
            'critical': data['cases']['critical'] ?? 0,
            'recovered': data['cases']['recovered'] ?? 0,
            'total_cases': data['cases']['total'] ?? 0,
          },
          'deaths': {
            'new': data['deaths']['new'] ?? 0,
            'total': data['deaths']['total'] ?? 0,
          },
          'tests': data['tests']['total'] ?? 0,
        },
        day: data['day'] ?? '',
      );
    } else {
      return Bulletin(
        statistics: {
          'cases': {
            'new': 0,
            'active': 0,
            'critical': 0,
            'recovered': 0,
            'total_cases': 0,
          },
          'deaths': {
            'new': 0,
            'total': 0,
          },
          'tests': 0,
        },
        day: '',
      );
    }
  }

  Future<Bulletin> fetchBulletin({String country = ''}) async {
    final response = await http.get(
      'https://covid-193.p.rapidapi.com/statistics?country=' +
          (country.isEmpty ? 'Philippines' : country.split(' ').join('-')),
      headers: {
        "x-rapidapi-host": "covid-193.p.rapidapi.com",
        "x-rapidapi-key": "7135d3a2ffmsha965d05c2a02029p15c27ejsnd5b531a402e2",
      },
    );

    if (response.statusCode == 200) {
      return Bulletin.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch bulletin');
    }
  }

  Widget make(data) {
    final formatCurrency =
        new NumberFormat.currency(symbol: '', decimalDigits: 0);
    return GridView.count(
      padding: const EdgeInsets.only(top: 5, bottom: 20),
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      shrinkWrap: true,
      childAspectRatio: 2 / 1,
      children: <Widget>[
        DetailBox(
          title: 'Cases',
          value: new Row(
            children: <Widget>[
              Text(
                formatCurrency
                    .format(data.statistics['cases']['total_cases'])
                    .toString(),
                style: subjectStyle,
              ),
              Text(
                ' (' + data.statistics['cases']['new'].toString() + ')',
                style: normalTextStyle,
              )
            ],
          ),
        ),
        DetailBox(
          title: 'Recovered',
          value: Text(
              formatCurrency
                  .format(data.statistics['cases']['recovered'])
                  .toString(),
              style: subjectStyle),
        ),
        DetailBox(
          title: 'Tested',
          value: Text(
            formatCurrency.format(data.statistics['tests']).toString(),
            style: subjectStyle,
          ),
        ),
        DetailBox(
          title: 'Deaths',
          value: new Row(
            children: <Widget>[
              Text(
                formatCurrency.format(data.statistics['deaths']['total']).toString(),
                style: subjectStyle,
              ),
              Text(
                ' (' + data.statistics['deaths']['new'].toString() + ')',
                style: normalTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
