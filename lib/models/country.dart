import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../src/extensions/string_extensions.dart';

class Country {
  List<String> getAllCountryNames() {
    return ['Philippines'];
  }

  Future initImages(context) async {
    const String flagsDir = 'assets/images/country_flags/';
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final countries = manifestMap.keys
        .where((String key) => key.contains(flagsDir))
        .map((flag) {
      final country = {};
      final String basePath = basename(new File(flag).path);
      country['filename'] = basePath;
      final String countryName = basePath
          .split('.')[0]
          .replaceAll(new RegExp(r'-'), ' ')
          .toPascalCase();
      country['name'] = countryName;
      return country;
    }).toList();

    return countries;
  }

  String cleanseCountryName(String country) {
    // substitute special named countries
    switch (country.toUpperCase()) {
      case 'UNITED STATES OF AMERICA':
        return 'USA';
        break;
      default:
        return country;
    }
  }
}
