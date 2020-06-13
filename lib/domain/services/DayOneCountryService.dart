
import 'dart:convert';

import 'package:covid19flutter/domain/models/DayOneCountry.dart';
import 'package:http/http.dart' as http;

class DayOneCountryService {
  static String API = "https://api.covid19api.com/total/dayone/country/";

  static Future<http.Response> fetch(String country) async {
    return await http.get(API+country);
  }

  static Future<List<DayOneCountry>> fetch2(String country) async {
    final response = await http.get(API+country);

    try{
      if(response.statusCode == 200)
        return DayOneCountry.fromJson(json.decode(response.body));
    } catch(ex){
      throw new Exception('failed to load countries');
    }
  }

  static Future<List<DayOneCountry>> fetchAll(List<String> names) async { //4 países
    List<DayOneCountry> countries = new List<DayOneCountry>();
    fetch2(names[0]).then((items) => countries.addAll(items) );
    fetch2(names[1]).then((items) => countries.addAll(items) );
    fetch2(names[2]).then((items) => countries.addAll(items) );
    fetch2(names[3]).then((items) => countries.addAll(items) );
    return await countries;
  }
}