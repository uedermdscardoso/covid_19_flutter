

import 'package:covid19flutter/domain/models/Global.dart';
import 'package:covid19flutter/widgets/cards/card_app.dart';
import 'package:covid19flutter/widgets/cards/fourth_card.dart';
import 'package:covid19flutter/widgets/cards/first_card.dart';
import 'package:covid19flutter/widgets/cards/second_card.dart';
import 'package:covid19flutter/widgets/cards/third_card.dart';
import 'package:flutter/material.dart';

class CardsGeral extends StatelessWidget {

  final Global information;
  final ValueChanged<int> onChanged;
  bool showLegend;

  CardsGeral({Key key, this.onChanged, this.information, this.showLegend }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutExpo,
      top: !showLegend ? _height * 0.18 : _height * 0.65,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: _height * .35,
        child: PageView(
          //physics: !showLegend ?  BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
          children: <Widget>[
            CardApp(child: FirstCard(information: information, title: "World")),
            CardApp(child: SecondCard(information: information)),
            CardApp(child: ThirdCard(countries: information.countries.getRange(0, 5).toList())),
            CardApp(child: FourthCard())
          ]
        ),
      ),
    );
  }
}
