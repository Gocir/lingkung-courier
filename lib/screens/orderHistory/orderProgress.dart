import 'package:flutter/material.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/widgets/orderHistory/onProgressCard.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';

class OrderProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courierProvider = Provider.of<CourierProvider>(context);
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadJunkSalesOnProgress(courierProvider.courierModel.id);

    return (junkSalesProvider.junkSalesOnProgress.isEmpty)
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/searching.png"),
                SizedBox(height: 16.0),
                CustomText(
                  text:
                      'Belum ada pesanan yang di proses nih. Ambil pesanan sekarang, yuk!',
                  align: TextAlign.center,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8.0),
            itemCount: junkSalesProvider.junkSalesOnProgress.length,
            itemBuilder: (_, index) {
              JunkSalesModel junkSales =
                  junkSalesProvider.junkSalesOnProgress[index];
              return OnProgressCard(courierModel: courierProvider.courierModel, junkSales: junkSales);
            },
          );
  }
}
