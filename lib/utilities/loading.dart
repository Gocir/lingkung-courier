import 'package:flutter/material.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Center(
        child: SpinKitRing(
          color: green,
          size: 50.0,
        ),
      ),
    );
  }
}