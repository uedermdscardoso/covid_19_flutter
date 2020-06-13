
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashbordBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.deepOrange[800],
          height: MediaQuery.of(context).size.height * .20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                      "assets/images/logo_covid19.png",
                      height: 75,
                      color: Colors.white
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Covid 19",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}