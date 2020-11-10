import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_courier/models/courierModel.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/screens/orderHistory/orderHistoryDetail/deliverOrders.dart';
import 'package:lingkung_courier/screens/orderHistory/orderHistoryDetail/receiveOrders.dart';
import 'package:lingkung_courier/screens/orderHistory/orderHistoryDetail/takeOrders.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:provider/provider.dart';

class OnProgressCard extends StatefulWidget {
  final CourierModel courierModel;
  final JunkSalesModel junkSales;
  OnProgressCard({this.courierModel, this.junkSales});
  @override
  _OnProgressCardState createState() => _OnProgressCardState();
}

class _OnProgressCardState extends State<OnProgressCard> {
  @override
  Widget build(BuildContext context) {
  final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
  junkSalesProvider.loadListTrash(widget.junkSales.id);
    return Card(
              child: ListTile(
                onTap: () {
                  (widget.junkSales.status == "Receive Orders")
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiveOrders(
                        courierModel: widget.courierModel,
                        junkSales: widget.junkSales),
                  ),
                )
              : (widget.junkSales.status == "Take Orders")
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TakeOrders(
                            courierModel: widget.courierModel,
                            junkSales: widget.junkSales),
                      ),
                    )
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeliverOrders(
                            courierModel: widget.courierModel,
                            junkSales: widget.junkSales),
                      ),
                    );
                },
                leading: CachedNetworkImage(
          imageUrl: widget.junkSales.trashImage.toString(),
          imageBuilder: (_, imageProvider) =>
              CircleAvatar(backgroundImage: imageProvider),
          placeholder: (_, url) => CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: SpinKitThreeBounce(
              color: black,
              size: 10.0,
            ),
          ),
          errorWidget: (_, url, error) => CircleAvatar(
            backgroundColor: Colors.grey[200],
            backgroundImage: AssetImage("assets/images/noimage.png"),
          ),
        ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: (widget.junkSales.status == "Start Orders")
                  ? 'Lagi Cari Scavanger' :
                      (widget.junkSales.status == "Receive Orders")
                  ? 'Lagi ke tempatmu'
                  : (widget.junkSales.status == "Take Orders")
                      ? 'Lagi ambil sampahmu'
                      : (widget.junkSales.status == "Deliver Orders")
                          ? 'Lagi anter sampahmu'
                          : 'Lagi di tujuan akhir',
                      color: green,
                      weight: FontWeight.w700,
                    ),
                    CustomText(
                      text: (widget.junkSales.businessName == null)
                          ? 'Loading...'
                          : 'BS. ${widget.junkSales.businessName}',
                      size: 16.0,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                subtitle: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12.0,
                      color: grey,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '${junkSalesProvider.listTrash.length} Jenis',
                      ),
                      TextSpan(text: ' º '),
                      TextSpan(
                        text:
                            '${widget.junkSales.directionModel.startPoint}',
                      ),
                    ],
                  ),
                ),
                trailing: Column(
                  children: <Widget>[
                    CustomText(
                      text: '15-25 menit',
                      size: 12.0,
                      color: grey,
                    ),
                    CustomText(
                      text: 'Estimasi waktu',
                      size: 12.0,
                      color: grey,
                    ),
                  ],
                ),
              ),
            );
  }
}
