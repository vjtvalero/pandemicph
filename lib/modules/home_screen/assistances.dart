import 'package:flutter/material.dart';
import 'package:pandemicph/models/assistance.dart';
import 'package:pandemicph/modules/home_screen/claim_screen.dart';

class Assistances extends StatefulWidget {
  @override
  _AssistancesState createState() => _AssistancesState();
}

class _AssistancesState extends State<Assistances> {
  List<Assistance> assistances = new List<Assistance>();
  AssistanceData asst = new AssistanceData();

  @override
  void initState() {
    super.initState();
    assistances = asst.seedData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: assistances.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AssistanceTile(assistances[index]);
            },
          ),
        ),
      ],
    );
  }
}

class AssistanceTile extends StatelessWidget {
  final Assistance asst;
  AssistanceTile(this.asst);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ClaimScreen.routeName,
          arguments: Assistance(
              asst.name, asst.provider, asst.bgColor, asst.requirements),
        );
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: asst.bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              asst.provider,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w200
              ),
            ),
            Text(
              asst.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
