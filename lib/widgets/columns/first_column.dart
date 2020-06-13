
import 'package:covid19flutter/domain/models/Country.dart';
import 'package:covid19flutter/widgets/alert/alert_country_data.dart';
import 'package:covid19flutter/widgets/columns/design_default.dart';
import 'package:flutter/material.dart';

class FirstColumn extends StatelessWidget {

  final List<Country> countries;
  final double height;

  const FirstColumn({Key key, this.height, this.countries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Segunda Coluna
        Container(
          margin: EdgeInsets.only(right: 5.0),
          decoration: BoxDecoration(
              color: Colors.transparent, //blue
              borderRadius: BorderRadius.circular(10)
          ),
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () => _showCountryData(context, countries.elementAt(0)),
                child: DesignDefault(
                  height: (height / 2) - 4,
                  position: 1,
                  country: countries.elementAt(0),
                ),
              ),
              GestureDetector(
                onTap: () => _showCountryData(context, countries.elementAt(1)),
                child: DesignDefault(
                  height: (height / 2) - 4,
                  position: 2,
                  country: countries.elementAt(1),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _showCountryData(BuildContext context, Country country) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertCountryData(country: country);
      },
    );
  }
}