
import 'package:covid19flutter/domain/models/Country.dart';
import 'package:intl/intl.dart';

class Global {
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  List<Country> countries;

  Global({ this.newConfirmed, this.totalConfirmed, this.newDeaths,
    this.totalDeaths, this.newRecovered, this.totalRecovered, this.countries });

  factory Global.fromJson(Map<String, dynamic> json){
    dynamic global = json['Global'];

    List<Country> values = new List<Country>();
    (json['Countries'] as List).asMap().forEach((dynamic index, dynamic country) => {
      values.add(new Country(
        country: country['Country'],
        countryCode: country['CountryCode'],
        slug: country['Slug'],
        newConfirmed:  country['NewConfirmed'] ?? 0,
        totalConfirmed: country['TotalConfirmed'] ?? 0,
        newDeaths: country['NewDeaths'] ?? 0,
        totalDeaths: country['TotalDeaths'] ?? 0,
        newRecovered: country['NewRecovered'] ?? 0,
        totalRecovered: country['TotalRecovered'] ?? 0,
        date: country['Date']
      ))
    });

    values.sort((a,b) => b.totalConfirmed.compareTo(a.totalConfirmed));

    return Global(
        newConfirmed: global['NewConfirmed'] ?? 0,
        totalConfirmed: global['TotalConfirmed'] ?? 0,
        newDeaths: global['NewDeaths'] ?? 0,
        totalDeaths: global['TotalDeaths'] ?? 0,
        newRecovered: global['NewRecovered'] ?? 0,
        totalRecovered: global['TotalRecovered'] ?? 0,
        countries: values
    );
  }

  static String formatNumber({ int number }){
    final formatter = new NumberFormat('###,###', 'eu');
    String numberFormatter = formatter.format(number);
    return numberFormatter;
  }

}