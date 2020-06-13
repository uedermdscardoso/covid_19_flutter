
import 'package:covid19flutter/domain/models/Global.dart';
import 'package:covid19flutter/utils/SizeTrackingWidget.dart';
import 'package:covid19flutter/widgets/columns/first_column.dart';
import 'package:covid19flutter/widgets/columns/second_column.dart';
import 'package:flutter/material.dart';

class BodyGeral extends StatelessWidget {

  final Global information;
  bool showLegend;
  double _height = 0;

  BodyGeral({ this.information, this.showLegend });

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery.of(context).size.height;

    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutExpo,
      top: !showLegend ? _height * 0.50 : _height * 1.10,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: _height * 0.42,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: FirstColumn(
                    countries: information.countries.getRange(0, 2).toList(),
                    height: _height * 0.42
                ),
              ),
              Expanded(
                child: SecondColumn(
                    showLegend: showLegend,
                    countries: information.countries.getRange(2,information.countries.length).toList(),
                    height: _height * 0.42),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }
}