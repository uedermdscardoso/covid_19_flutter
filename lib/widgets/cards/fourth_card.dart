
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FourthCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FourthCardState();
}

class _FourthCardState extends State<FourthCard> {

  static final String URL = "https://covid19api.com/";
  bool _buttonPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              "COVID 19 - API",
            style: TextStyle(color: Colors.deepOrange, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Container(
            width: 250,
            child: Text(
              "Know the API used in this app to show COVID 19 data.",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 0.5, color: Colors.deepOrange)
            ),
            child: RaisedButton(
              onPressed: () async => {
                if(await canLaunch(URL)){
                  await launch(URL, forceSafariVC: false)
                }
              },
              onHighlightChanged: (pressed) {
                setState(() {
                  _buttonPressed = pressed;
                });
              },
              hoverElevation: 0,
              highlightElevation: 0,
              focusElevation: 0,
              disabledElevation: 0,
              elevation: 0,
              color: Colors.transparent,
              highlightColor: Colors.deepOrange,
              disabledTextColor: Colors.deepOrange,
              textColor: _buttonPressed ? Colors.white : Colors.deepOrange,
              child: Text("ACCCESS WEBSITE"),
            ),
          )
        ],
      ),
    );
  }
}
