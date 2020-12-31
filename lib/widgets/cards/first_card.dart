
import 'package:covid19flutter/domain/models/Global.dart';
import 'package:flutter/material.dart';

class FirstCard extends StatelessWidget {

  String title = "";
  Global information;

  FirstCard({ this.title, this.information });

  int calcPercentTotal({ dynamic first, dynamic second }){
    return ((first * 100) / second).round();
  }

  @override
  Widget build(BuildContext context) {

    int totalNotRecovered = information.totalConfirmed - (information.totalRecovered + information.totalDeaths);
    int percentTotalNotRecovered = calcPercentTotal(first: totalNotRecovered, second: information.totalConfirmed);
    int percentTotalRecovered = calcPercentTotal(first: information.totalRecovered, second: information.totalConfirmed);
    int percentTotalDeaths = calcPercentTotal(first: information.totalDeaths, second: information.totalConfirmed);

    //print("percentTotalNotRecovered: "+percentTotalNotRecovered.toString());
    //print("percentTotalRecovered: "+percentTotalRecovered.toString());
    //print("percentTotalDeaths: "+percentTotalDeaths.toString());

    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(bottom: 8), child: Text(title)),
                        Text(Global.formatNumber(number: information.totalConfirmed),style: TextStyle(color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold)),
                        Text("confirmed",style: TextStyle(color: Colors.redAccent, fontSize: 16)),

                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Column(
                                  children: <Widget>[
                                    Text(Global.formatNumber(number: information.totalRecovered), style: TextStyle(color: Colors.lightGreen, fontSize: 20, fontWeight: FontWeight.bold)),
                                    Text("recovered",style: TextStyle(color: Colors.lightGreen, fontSize: 16)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Column(
                                  children: <Widget>[
                                    Text(Global.formatNumber(number: information.totalDeaths), style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
                                    Text("deaths",style: TextStyle(color: Colors.blueGrey, fontSize: 16)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(flex: percentTotalNotRecovered, child: Container(color: Colors.blue)),
                        Expanded(flex: percentTotalRecovered, child: Container(color: Colors.lightGreen)),
                        Expanded(flex: percentTotalDeaths, child: Container(color: Colors.blueGrey))
                      ],
                    ),
                    width: 7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(color: Colors.blue, width: 15, height: 15),
                SizedBox(width: 5),
                Text("Unrecovered ") //Não recuperados
              ],
            ),
          ),
        ),
      ],
    );
  }

}
