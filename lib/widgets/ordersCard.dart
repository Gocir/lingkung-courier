import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/models/trashCartModel.dart';
import 'package:lingkung_courier/screens/ordersDetail.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';

class OrdersCard extends StatefulWidget {
  final JunkSalesModel junkSales;
  final List<TrashCartModel> listTrash;
  OrdersCard({this.junkSales, this.listTrash});
  @override
  _OrdersCardState createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OrdersDetail(junkSales: widget.junkSales),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(8.0),
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
        title: CustomText(
          text: '${widget.junkSales.userName}',
          weight: FontWeight.w700,
        ),
        subtitle: RichText(
          text: TextSpan(
            style: TextStyle(
                fontFamily: "Poppins",
                color: black,
                fontSize: 14.0,
                fontWeight: FontWeight.w600),
            children: [
              TextSpan(
                text: NumberFormat.currency(
                        locale: 'id', symbol: 'Rp', decimalDigits: 0)
                    .format(widget.junkSales.profitTotal),
              ),
              TextSpan(
                text: ', ${widget.junkSales.amountTrash} Jenis Sampah',
              ),
            ],
          ),
        ),
        trailing: CustomText(
          text: '07.00',
          size: 12.0,
        ),
      ),
    );
  }
}
