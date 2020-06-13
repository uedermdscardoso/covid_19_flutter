
import 'package:covid19flutter/domain/models/Global.dart';
import 'package:covid19flutter/domain/services/GlobalService.dart';
import 'package:covid19flutter/domain/services/UtilitiesService.dart';
import 'package:covid19flutter/widgets/body_geral.dart';
import 'package:covid19flutter/widgets/cards_geral.dart';
import 'package:covid19flutter/widgets/dashboard_bar.dart';
import 'package:covid19flutter/widgets/legend/legend.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  Global _information = new Global();
  bool _showLegend = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepOrange[800],
      body: Container(
        child: FutureBuilder(
          future: GlobalService.fetchGlobal2(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              _information = snapshot.data;
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  DashbordBar(),

                  CardsGeral(showLegend: _showLegend, information: _information),

                  BodyGeral(showLegend: _showLegend, information: _information),

                  Legend(
                    top: _showLegend ? _height * 0.2055 : _height * 1.25,
                    showLegend: _showLegend,
                    countries: _information.countries,
                  ),

                  //Seta para abrir a legenda
                  Positioned(
                      top: _height * 0.16,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => setState(() => _showLegend = !_showLegend ),
                            child: Container(
                              width: 30,
                              height: 30,
                              child: Center(
                                child: FaIcon(
                                    _showLegend ? FontAwesomeIcons.chevronUp : FontAwesomeIcons.chevronDown,
                                    color: Colors.white,
                                    size: 18
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  )
                ],
              );
            }
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent)),
                SizedBox(height: 12),
                Text("loading data", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))
              ],
            ),
            );
          },
        )
      ),
    );
  }
}