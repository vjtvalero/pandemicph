import 'package:flutter/material.dart';

class Assistance {
  String name;
  String provider;
  Color bgColor;
  List<String> requirements;
  Assistance(this.name, this.provider, this.bgColor, this.requirements);
}

class AssistanceData {
  List<Assistance> seedData() {
    final List<Assistance> asstList = List<Assistance>();

    Assistance asst = new Assistance(
      'Cash Relief Assistance',
      'IATF',
      Color(0xFFF0B67F),
      [
        'I am 18 years old and above.',
        'We are more than 3 in the family',
        'My family includes a senior citizen.',
        'I have more than 3 children.',
      ],
    );
    asstList.add(asst);

    asst = new Assistance(
      'Social Amelioration Program',
      'DSWD',
      Color(0xFF55868C),
      [
        'I am 18 years old and above.',
        'We are more than 3 in the family',
        'My family includes a senior citizen.',
        'I have more than 3 children.',
      ],
    );
    asstList.add(asst);

    asst = new Assistance(
      'Mitigating Measures',
      'DOLE',
      Color(0xFF7F636E),
      [
        'I am 18 years old and above.',
        'We are more than 3 in the family',
        'My family includes a senior citizen.',
        'I have more than 3 children.',
      ],
    );
    asstList.add(asst);

    return asstList;
  }
}
