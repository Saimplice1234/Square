import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main.dart';

class SplashScreenCustom extends StatefulWidget {
  @override
  _SplashScreenCustomState createState() => _SplashScreenCustomState();
}

class _SplashScreenCustomState extends State<SplashScreenCustom> {
  @override
  void initState(){
    super.initState();
    //start 1
    Timer(Duration(seconds:3),(){
      setState(() {
        initialOpacity=0;
      });
      //end 1
      //start 2
      Timer(Duration(milliseconds:500),(){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) {
          return MyHomePage();
        }
        ));
      });
      //end 2
    });
  }
  int initialOpacity=1;
  @override
  Widget build(BuildContext context) {
    return ElasticInDown(
      child: Hero(
        tag:'logo',
        child:Container(
          child:AnimatedOpacity(
            duration:Duration(milliseconds:500),
            opacity:initialOpacity.toDouble(),
            child: SpinKitFadingCube(
              color:Colors.red,
            ),
          ),
        ),
      )
    );
  }
}
