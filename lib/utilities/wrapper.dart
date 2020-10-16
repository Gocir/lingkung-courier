import 'package:flutter/material.dart';
import 'package:lingkung_courier/main.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/screens/authenticate/login.dart';
import 'package:lingkung_courier/screens/profileDetail/accountStatus.dart';
import 'package:lingkung_courier/screens/profileDetail/dataVerification.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<CourierProvider>(context);
    print(auth);
      // if(auth.status == Status.Uninitialized){
      //   return Loading();
      // }else if (auth.status == Status.Authenticated){
      //   return HomePage();
      // }else {
      //   return LoginPage();
      // }
      switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return MainPage();
      case Status.Registering:
        return DataVerification();
      case Status.Verify:
        return AccountStatus();
      default:
        return LoginPage();
    }
  }
}