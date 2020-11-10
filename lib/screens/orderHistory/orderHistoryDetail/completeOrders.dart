import 'package:flutter/material.dart';
import 'package:lingkung_courier/models/courierModel.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/main.dart';
import 'package:flutter/cupertino.dart';

class CompleteOrders extends StatefulWidget {
  final CourierModel courierModel;
  final JunkSalesModel junkSales;
  CompleteOrders({this.courierModel, this.junkSales});
  @override
  _CompleteOrdersState createState() => _CompleteOrdersState();
}

class _CompleteOrdersState extends State<CompleteOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme: IconThemeData(color: black),
          automaticallyImplyLeading: false,
          leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_down),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
          },
        ),
          title: CustomText(
            text: 'Riwayat Pesanan',
            size: 18.0,
            weight: FontWeight.w600,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: CustomText(
                  text: 'TakeOrders',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
