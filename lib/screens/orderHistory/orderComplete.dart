import 'package:flutter/material.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/widgets/orderHistory/completeHistoryCard.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:lingkung_courier/providers/partnerProvider.dart';

class OrderComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courierProvider = Provider.of<CourierProvider>(context);
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    final partnerProvider = Provider.of<PartnerProvider>(context);
    junkSalesProvider.loadJunkSalesComplete(courierProvider.courierModel);

    return (junkSalesProvider.junkSalesComplete.isEmpty) ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/searching.png"),
                SizedBox(height: 16.0),
                CustomText(
                  text:
                      'Belum ada pesanan yang di selesaikan. Ambil dan selesaikan pesanan yuk!',
                  align: TextAlign.center,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ) :
    ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8.0),
      itemCount: junkSalesProvider.junkSalesComplete.length,
      itemBuilder: (_, index) {
        JunkSalesModel junkSales = junkSalesProvider.junkSalesComplete[index];
        return CompleteHistoryCard(courierModel: courierProvider.courierModel, junkSales: junkSales);
      },
    );
  }
}
