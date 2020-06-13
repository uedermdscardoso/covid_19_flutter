
import 'dart:convert';

import 'package:covid19flutter/domain/models/Global.dart';
import 'package:http/http.dart' as http;

class GlobalService {

  static Future<http.Response> fetchGlobal() async {
    return await http.get('https://api.covid19api.com/summary');
  }

  static Future<Global> fetchGlobal2() async {
    final response = await http.get("https://api.covid19api.com/summary");

    try{
        if(response.statusCode == 200)
          return Global.fromJson(json.decode(response.body));
    } catch(ex){
      throw new Exception('failed to load countries');
    }
  }

}