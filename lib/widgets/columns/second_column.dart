
import 'package:covid19flutter/domain/models/Country.dart';
import 'package:covid19flutter/domain/models/Global.dart';
import 'package:covid19flutter/domain/services/UtilitiesService.dart';
import 'package:flutter/material.dart';

import '../alert/alert_country_data.dart';

class SecondColumn extends StatelessWidget {

  final List<Country> countries;
  final double height;
  bool showLegend;

  SecondColumn({Key key, this.height, this.countries, this.showLegend }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Primeira Coluna
        Container(
          margin: EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(
              color: Colors.white60, //Colors.white60,
              borderRadius: BorderRadius.circular(10)
          ),
          height: height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index){
                String countryName = countries.elementAt(index).slug.replaceAll("-", " ");
                countryName = UtilitiesService.capitalizeAllWord(countryName);

                return GestureDetector(
                  onTap: () => _showCountryData(context, countries.elementAt(index)),
                  child: Column(
                    children: <Widget>[
                      Text(countryName, style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                      Container(color: Colors.grey, width: double.infinity, height: 0.5, margin: EdgeInsets.only(top: 5, bottom: 5))
                    ],
                  ),
                );
              },
            ),
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