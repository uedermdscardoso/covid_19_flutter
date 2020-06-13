
import 'package:flutter/material.dart';

class ItemLegend extends StatelessWidget {

  String countryCode; //Siglas
  String countryName;

  ItemLegend({ this.countryCode, this.countryName }); //Nomes dos países

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.network("https://www.countryflags.io/${countryCode
              .trim()}/flat/32.png"),
          SizedBox(width: 8),
          Text(countryCode.toUpperCase(), style: TextStyle(fontSize: 18, color: Colors.black45)),
          SizedBox(width: 8),
          Text("- ${countryName}", style: TextStyle(fontSize: 18, color: Colors.black45)),
        ],
      ),
    );
  }
}
