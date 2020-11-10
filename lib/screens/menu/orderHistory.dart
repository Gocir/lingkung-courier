import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Utilities
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';
// Widgets
import 'package:lingkung_courier/screens/orderHistory/orderComplete.dart';
import 'package:lingkung_courier/screens/orderHistory/orderProgress.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final _kTabs = <Tab>[
      Tab(text: 'Dalam Proses'),
      Tab(text: 'Selesai'),
    ];

    final _kPages = <Widget>[
      OrderProgress(),
      OrderComplete(),
    ];

    return DefaultTabController(
      length: _kTabs.length,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: yellow,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: CustomText(
              text: 'Riwayat Pesanan',
              size: 18.0,
              color: black,
              weight: FontWeight.w600,
            ),
            bottom: TabBar(
              indicatorColor: blue,
              labelColor: blue,
              labelStyle: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelColor: black.withOpacity(0.6),
              unselectedLabelStyle: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.normal,
              ),
              tabs: _kTabs,
            ),
            flexibleSpace: Row(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-14.23, 23.85),
                  child:
                      // Adobe XD layer: 'grass1' (shape)
                      Container(
                    width: 118.0,
                    height: 85.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/grass3.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(150, -10.93),
                  child:
                      // Adobe XD layer: 'grass2' (shape)
                      Container(
                    width: 133.0,
                    height: 149.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/grass222.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: _kPages),
        ),
      ),
    );
  }
}
