
import 'package:covid19flutter/domain/models/Country.dart';
import 'package:covid19flutter/domain/models/Global.dart';
import 'package:covid19flutter/domain/services/UtilitiesService.dart';
import 'package:flutter/material.dart';

class DesignDefault extends StatefulWidget {

  int position;
  double height;
  Country country;

  DesignDefault({ this.position, this.height, this.country });

  @override
  State<StatefulWidget> createState() => DesignDefaultState();
}

class DesignDefaultState extends State<DesignDefault> {

  @override
  Widget build(BuildContext context) {

    String countryName = widget.country.slug.replaceAll("-", " ");
    countryName = UtilitiesService.capitalizeAllWord(countryName);

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: ClipRRect(
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.deepOrange, width: 1.5),
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(widget.position.toString(), style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))
                ),
              ),
            ),
          ),
          //Text("1° Caso", style: TextStyle(fontSize: 22)),
          Text(Global.formatNumber(number: widget.country.totalConfirmed), style: TextStyle(fontSize: 26, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
          Text("confirmed cases", style: TextStyle(fontSize: 16, color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(countryName, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, //Colors.white60,
          borderRadius: BorderRadius.circular(10)
      ),
      height: widget.height,
    );
  }
}
