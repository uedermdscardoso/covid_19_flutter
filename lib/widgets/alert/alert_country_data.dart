
import 'package:covid19flutter/domain/models/Country.dart';
import 'package:covid19flutter/domain/models/DayOneCountry.dart';
import 'package:covid19flutter/domain/models/Global.dart';
import 'package:covid19flutter/domain/services/DayOneCountryService.dart';
import 'package:covid19flutter/domain/services/UtilitiesService.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AlertCountryData extends StatelessWidget {

  Country country;

  final colors = [
    charts.MaterialPalette.red.makeShades(2),
    charts.MaterialPalette.green.makeShades(2),
    charts.MaterialPalette.gray.makeShades(2),
  ];

  AlertCountryData({ this.country });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DayOneCountryService.fetch2(country.slug.trim()),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return _showAlertDialog(context: context, country: country, allData: snapshot.data);
        }
        return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent)),
            SizedBox(height: 12),
          ],
        ),
        );
      },
    );
  }

  Widget _showAlertDialog({ BuildContext context, Country country, List<DayOneCountry> allData }){

    DayOneCountry secondToLast;
    if(!allData.isEmpty)
      secondToLast = allData.elementAt(allData.length-2);

    String countryName = UtilitiesService.capitalizeAllWord(country.slug.replaceAll("-", " "));

    return AlertDialog(
      title: Text(countryName, textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _showChart(allData: allData), //Exibe o gráfico
            SizedBox(height: 20),
            _showNewCases(country: country, secondToLast: secondToLast), //exibe os novos casos
            SizedBox(height: 20),
            _showTotalCases(), //Exibe os totais
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12, bottom: 12),
          child: GestureDetector(
            child: Text('OK', style: TextStyle(color: Colors.deepOrange[800], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  Widget _showTotalCases({ TextStyle textStyle }){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[ //confirmed
              Text(Global.formatNumber(number: country.totalConfirmed), style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: <Widget>[ //recovered
              Text(Global.formatNumber(number: country.totalRecovered), style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: <Widget>[ //deaths
              Text(Global.formatNumber(number: country.totalDeaths), style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      );
  }

  Widget _showNewCases({ Country country, DayOneCountry secondToLast , TextStyle textStyle }){

    int newCases = secondToLast != null ? country.totalConfirmed - secondToLast.confirmed : 0;
    int newRecovered = secondToLast != null ? country.totalRecovered - secondToLast.recovered : 0;
    int newDeaths = secondToLast != null ? country.totalDeaths - secondToLast.deaths : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("+"+Global.formatNumber(number: newCases), style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(width: 15),
        Column(
          children: <Widget>[
            Text("+"+Global.formatNumber(number: newRecovered), style: TextStyle(color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(width: 15),
        Column(
          children: <Widget>[
            Text("+"+Global.formatNumber(number: newDeaths), style: TextStyle(color: Colors.grey, fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  List<charts.Series<DayOneCountry, DateTime>> _createSampleData({ colors, List<DayOneCountry> allData }) {
    List<charts.Series<DayOneCountry, DateTime>> result = new List<charts.Series<DayOneCountry, DateTime>>();

    /*List<DayOneCountry> data = new List<DayOneCountry>();
    for(int i=0; i<allData.length-1; i++){
      if(data.length == 0){
        data.add(allData.elementAt(i));
      } else if(allData.elementAt(i+1).confirmed > allData.elementAt(i).confirmed){
        DayOneCountry aux = new DayOneCountry();
        aux.confirmed = allData.elementAt(i+1).confirmed - allData.elementAt(i).confirmed;
        aux.date = allData.elementAt(i+1).date;
        data.add(aux);
      } else if(allData.elementAt(i).confirmed == allData.elementAt(i).confirmed) {
        DayOneCountry aux = new DayOneCountry();
        aux.confirmed = allData.elementAt(i).confirmed;
        aux.date = allData.elementAt(i).date;
        data.add(aux);
      }
    }*/

    for(int i=0; i < 3; i++) {
      result.add(new charts.Series<DayOneCountry, DateTime>(
          id: 'Country' + i.toString(),
          colorFn: (_, __) => colors[i][1],
          domainFn: (DayOneCountry country, _) =>
              DateTime.parse(country.date),
          measureFn: (DayOneCountry country, _) {
            switch (i) {
              case 0:
                return country.confirmed;
              case 1:
                return country.recovered;
              case 2:
                return country.deaths;
            }
          },
          data: allData,
          labelAccessorFn: (DayOneCountry country, _) => '${country.country}'
      ));
    }
    return result;
  }


  Widget _showChart({ List<DayOneCountry> allData }){
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 4 / 2,
          child: new charts.TimeSeriesChart(
            _createSampleData(colors: colors, allData: allData),
            animate: true,
            defaultRenderer: new charts.LineRendererConfig(),
            dateTimeFactory: const charts.LocalDateTimeFactory(),
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(color: Color(int.parse(colors[0][1].hexString.replaceAll("#", "0xff"))), width: 15, height: 15),
            SizedBox(width: 5),
            Text("confirmed"),
            SizedBox(width: 10),
            Container(color: Color(int.parse(colors[1][1].hexString.replaceAll("#", "0xff"))), width: 15, height: 15),
            SizedBox(width: 5),
            Text("recovered"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 32),
            Container(color: Color(int.parse(colors[2][1].hexString.replaceAll("#", "0xff"))), width: 15, height: 15),
            SizedBox(width: 8),
            Text("deaths"),
          ],
        ),
      ],
    );
  }
}
