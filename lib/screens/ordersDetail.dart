import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:lingkung_courier/providers/partnerProvider.dart';
import 'package:lingkung_courier/providers/userProvider.dart';
import 'package:lingkung_courier/screens/orderHistory/orderHistoryDetail/receiveOrders.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';

class OrdersDetail extends StatefulWidget {
  final JunkSalesModel junkSales;
  OrdersDetail({this.junkSales});
  @override
  _OrdersDetailState createState() => _OrdersDetailState();
}

class _OrdersDetailState extends State<OrdersDetail> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    partnerProvider.loadSinglePartner(widget.junkSales.partnerId);
    userProvider.loadSingleUser(widget.junkSales.userId);
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                elevation: 0,
                iconTheme: IconThemeData(color: black),
                automaticallyImplyLeading: false,
                title: Stack(
                  children: [
                    Image.asset('assets/images/logos.png', height: 35.0),
                    Positioned(
                      left: 51.0,
                      top: 23.5,
                      child: CustomText(
                        text: 'courier',
                        color: blue,
                        size: 10.0,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircle,
                                  color: blue,
                                  size: 10.0,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: RichText(
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${userProvider.userModel?.name}\n',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 18.0,
                                          color: black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${widget.junkSales?.directionModel?.startPoint}',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14.0,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircle,
                                  color: yellow,
                                  size: 10.0,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: RichText(
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'BS. ${partnerProvider.partnerModel?.businessName}\n',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 18.0,
                                          color: black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${widget.junkSales?.directionModel?.destination}',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14.0,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomText(
                                text: "Harga",
                                weight: FontWeight.w600,
                              ),
                              CustomText(
                                  text: NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp',
                                          decimalDigits: 0)
                                      .format(widget.junkSales.profitTotal),
                                  size: 16.0,
                                  weight: FontWeight.w700),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomText(
                                text: "Pendapatan",
                                weight: FontWeight.w600,
                              ),
                              CustomText(
                                text: NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp',
                                        decimalDigits: 0)
                                    .format(widget.junkSales.deliveryCosts),
                                size: 16.0,
                                weight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: 80.0,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3, 0),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 48.0,
                      child: OutlineButton(
                        color: white,
                        highlightColor: white,
                        highlightedBorderColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                        child: Icon(
                          CupertinoIcons.xmark,
                          size: 26,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        height: 48,
                        child: FlatButton(
                          color: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            text: 'TERIMA',
                            color: white,
                            size: 16.0,
                            weight: FontWeight.w700,
                          ),
                          onPressed: () {
                            takeOrders();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void takeOrders() async {
    final junkSales = Provider.of<JunkSalesProvider>(context, listen: false);
    final courier = Provider.of<CourierProvider>(context, listen: false);

    await junkSales.updateJunkSales(
      status: "Receive Orders",
      courierId: courier.courierModel.id,
      courierName: courier.courierModel.courierName,
      junkSalesModel: widget.junkSales,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiveOrders(junkSales: widget.junkSales),
      ),
    );
  }
}
