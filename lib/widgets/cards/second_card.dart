
import 'package:covid19flutter/domain/models/Country.dart';
import 'package:covid19flutter/domain/models/Global.dart';
import 'package:covid19flutter/domain/services/UtilitiesService.dart';
import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SecondCard extends StatelessWidget {

  Global information;
  int _last;
  List<charts.Series<Country, String>> seriesList;
  final legendColors = [Colors.blue, Colors.red, Colors.green, Colors.purple];

  SecondCard({this.information});

  @override
  Widget build(BuildContext context) {

    List<Country> cases = information.countries.toList().getRange(0, 4).toList();

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 4 / 2,
            child: new charts.BarChart(
              _createSampleData(cases),
              animate: true,
              vertical: false,
              domainAxis: new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
              barRendererDecorator: new charts.BarLabelDecorator(
                  insideLabelStyleSpec: new charts.TextStyleSpec(
                    fontSize: 15,
                    color: charts.Color.fromHex(code: charts.MaterialPalette.black.rgbaHexString),
                    fontWeight: "bold"
                  ),
                  outsideLabelStyleSpec: new charts.TextStyleSpec(
                    fontSize: 15,
                    color: charts.Color.fromHex(code: charts.MaterialPalette.black.rgbaHexString),
                    fontWeight: "bold"
                  ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showValues(country: cases.elementAt(0), indexColor: 0),
              showValues(country: cases.elementAt(1), indexColor: 1),
              showValues(country: cases.elementAt(2), indexColor: 2),
              showValues(country: cases.elementAt(3), indexColor: 3),
            ],
          )
        ],

      ),
    );
  }

  static List<charts.Series<Country, String>> _createSampleData(List<Country> cases) {
    final blue = charts.MaterialPalette.blue.makeShades(2);
    final red = charts.MaterialPalette.red.makeShades(2);
    final green = charts.MaterialPalette.green.makeShades(2);
    final purple = charts.MaterialPalette.purple.makeShades(2);

    return [
      new charts.Series<Country, String>(
        id: 'Country',
        colorFn: (Country country, _) {
          if(country.country.compareTo(cases.elementAt(0).country) == 0)
            return blue[1];
          else if(country.country.compareTo(cases.elementAt(1).country) == 0) {
            return red[1];
          } else if(country.country.compareTo(cases.elementAt(3).country) == 0)
            return green[1];
          else
            return purple[1];
        },
        domainFn: (Country country, _) => country.country,
        measureFn: (Country country, _) => country.totalConfirmed,
        data: cases,
        labelAccessorFn: (Country country, _) => '${Global.formatNumber(number: country.totalConfirmed)}'
      )
    ];
  }

  Widget showValues({ int indexColor, Country country}){
    return new Row(
        children: <Widget>[
          SizedBox(width: 5),
          Container(color: legendColors[indexColor], width: 15, height: 15),
          SizedBox(width: 5),
          Text(country.countryCode),
          SizedBox(width: 5),
        ],
    );
  }
}
