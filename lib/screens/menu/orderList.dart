import 'package:flutter/material.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:lingkung_courier/widgets/ordersCard.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  JunkSalesModel junkSales;

  @override
  Widget build(BuildContext context) {
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadJunkSales();
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: yellow,
          elevation: 1.5,
          iconTheme: IconThemeData(color: black),
          automaticallyImplyLeading: false,
          title: CustomText(
            text: 'Pesanan',
            size: 18.0,
            weight: FontWeight.w600,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.help_outline,
                color: black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: (junkSalesProvider.junkSales.isEmpty)
            ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image.asset("assets/images/searching.png"),
                  SizedBox(height: 16.0),
                  CustomText(
                    text:
                        'Tunggu sebentar, kami sedang mencarikan pesanan untukmu nih...',
                    align: TextAlign.center,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                itemCount: junkSalesProvider.junkSales.length,
                itemBuilder: (_, index) {
                  junkSales = junkSalesProvider.junkSales[index];
                  return OrdersCard(junkSales: junkSales);
                },
              ),
      ),
    );
  }
}
