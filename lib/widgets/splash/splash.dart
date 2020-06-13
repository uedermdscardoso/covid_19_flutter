
import 'package:covid19flutter/views/dashboard.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    delay(); //Show splash for 2 seconds
  }

  Future<void> delay() async{
    return await Future.delayed(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation){
        return Dashboard();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/logo_covid19.png", width: 75, height: 75, color: Colors.white),
                  Text("COVID 19", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text("WORLD", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
