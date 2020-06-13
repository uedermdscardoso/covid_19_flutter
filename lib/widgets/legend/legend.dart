
import 'dart:ffi';

import 'package:covid19flutter/domain/models/Country.dart';
import 'package:covid19flutter/domain/services/UtilitiesService.dart';
import 'package:covid19flutter/widgets/legend/item_legend.dart';
import 'package:flutter/material.dart';

class Legend extends StatefulWidget {
  double top;
  bool showLegend;
  List<Country> countries;

  Legend({Key key, this.top, this.showLegend, this.countries }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LegendState();
}

class _LegendState extends State<Legend> {

  bool _showDefault;
  List<Country> _newList = new List<Country>();

  @override
  void initState() {
    super.initState();

    setState(() {
      _showDefault = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.decelerate,
      top: widget.top,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 100),
        opacity: widget.showLegend ? 1 : 0,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.45,
          color: Colors.white60,
          child: Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25, left: 18, right: 18),
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value){
                    _newList.clear();
                    if(!value.isEmpty) {
                      widget.countries.forEach((country) {
                        if (UtilitiesService.like(word: country.countryCode.toLowerCase(), search: value.toLowerCase())) {
                          setState(() {
                            _newList.add(country);
                          });
                        }
                      });

                      setState(() {
                        _showDefault = false;
                      });
                    } else
                      setState(() {
                        _showDefault = true;
                      });
                  },
                  decoration: InputDecoration(
                    labelText: 'Country Code',
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    )
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _showDefault ? widget.countries.length : _newList.length,
                    itemBuilder: (context, index){
                      return ItemLegend(
                          countryCode: (_showDefault ? widget.countries : _newList).elementAt(index).countryCode,
                          countryName: UtilitiesService.capitalizeAllWord(
                              (_showDefault ? widget.countries : _newList).elementAt(index).slug.replaceAll("-", " "))
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


