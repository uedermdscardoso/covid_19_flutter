
import 'package:covid19flutter/domain/models/Country.dart';
import 'package:covid19flutter/domain/models/DayOneCountry.dart';
import 'package:covid19flutter/domain/services/DayOneCountryService.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ThirdCard extends StatefulWidget {

  List<Country> countries;

  ThirdCard({this.countries});

  final colors = [
    charts.MaterialPalette.blue.makeShades(2),
    charts.MaterialPalette.red.makeShades(2),
    charts.MaterialPalette.purple.makeShades(2),
    charts.MaterialPalette.green.makeShades(2),
  ];

  @override
  State<StatefulWidget> createState() => _ThirdCardState();
}

class _ThirdCardState extends State<ThirdCard> {

  Future<List<DayOneCountry>> first, second, third, fourth;
  int pos = 0;

  @override
  void initState() {
    super.initState();

    first = DayOneCountryService.fetch2(widget.countries.elementAt(0).slug);
    second = DayOneCountryService.fetch2(widget.countries.elementAt(1).slug);
    third = DayOneCountryService.fetch2(widget.countries.elementAt(2).slug);
    fourth = DayOneCountryService.fetch2(widget.countries.elementAt(3).slug);

  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: FutureBuilder(
        future: Future.wait([first, second, third, fourth]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
          if(snapshot.hasData){

            List<List<DayOneCountry>> allData = new List<List<DayOneCountry>>();
            allData.add(snapshot.data[0]);
            allData.add(snapshot.data[1]);
            allData.add(snapshot.data[2]);
            allData.add(snapshot.data[3]);

            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => this.setState(() => pos = 0),
                      child: Text("Confirmed Cases",
                      style: TextStyle(fontWeight: pos == 0 ? FontWeight.bold : FontWeight.normal))
                    ),
                    SizedBox(width: 5),
                    Text("|"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => this.setState(() => pos = 1),
                        child: Text("Recovered Cases", style: TextStyle(fontWeight: pos == 1 ? FontWeight.bold : FontWeight.normal))
                    ),
                    SizedBox(width: 5),
                    Text("|"),
                    SizedBox(width: 5),
                    GestureDetector(
                        onTap: () => this.setState(() => pos = 2),
                        child: Text("Death Cases", style: TextStyle(fontWeight: pos == 2 ? FontWeight.bold : FontWeight.normal))
                    ),
                  ],
                ),
                AspectRatio(
                  aspectRatio: 4 / 2,
                  child: new charts.TimeSeriesChart(
                    _createSampleData(widget.colors, allData, pos),
                    animate: true,
                    defaultRenderer: new charts.LineRendererConfig(),
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      showValues(index: 0, countries: snapshot.data[0]),
                      showValues(index: 1, countries: snapshot.data[1]),
                      showValues(index: 2, countries: snapshot.data[2]),
                      showValues(index: 3, countries: snapshot.data[3]),
                    ],
                  ),
                )
              ],
            );
          }
          return showCircularProgress();
        },
      )
    );
  }

  static List<charts.Series<DayOneCountry, DateTime>> _createSampleData(colors, List<List<DayOneCountry>> allData, int pos) {
    List<charts.Series<DayOneCountry, DateTime>> result = new List<charts.Series<DayOneCountry, DateTime>>();
    for(int i=0; i<4; i++){
      result.add(new charts.Series<DayOneCountry, DateTime>(
          id: 'Country'+i.toString(),
          colorFn: (_, __) => colors[i][1],
          domainFn: (DayOneCountry country, _) => DateTime.parse(country.date),
          measureFn: (DayOneCountry country, _) {
            switch(pos){
              case 0: return country.confirmed;
              case 1: return country.recovered;
              case 2: return country.deaths;
            }
          },
          data: allData.elementAt(i),
          labelAccessorFn: (DayOneCountry country, _) => '${country.country}'
      ));
    }
    return result;
  }

  //Exibe os valores
  Widget showValues({ int index, List<DayOneCountry> countries }){
    return new Row(
      children: <Widget>[
        Container(color: Color(int.parse(widget.colors[index][1].hexString.replaceAll("#", "0xff"))), width: 15, height: 15),
        SizedBox(width: 5),
        Text(widget.countries.elementAt(index).countryCode),
        SizedBox(width: 10),
      ],
    );
  }

  Widget showCircularProgress(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
            backgroundColor: Colors.deepOrange,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent)),
      ],
    ),
    );
  }
}
//https://flutterawesome.com/tag/chart/
//https://google.github.io/charts/flutter/example/bar_charts/horizontal_bar_label.html
//https://google.github.io/charts/flutter/example/line_charts/area_and_line.html