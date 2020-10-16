import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lingkung_courier/screens/introduction/onboarding.dart';
import 'package:lingkung_courier/utilities/wrapper.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future checkFirstSeen() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool _seen = (prefs.getBool('seen') ?? false);

        if (_seen) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Wrapper()));
        } else {
        await prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Onboarding()));
        }
    }

  @override
  void initState(){
    super.initState();
    new Timer(new Duration(milliseconds: 300), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment(0, 0.75),
              child: Image.asset(
                'assets/images/logos.png',
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/savearth.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
