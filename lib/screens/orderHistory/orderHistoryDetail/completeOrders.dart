import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingkung_courier/models/courierModel.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/models/trashCartModel.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CompleteOrders extends StatefulWidget {
  final CourierModel courierModel;
  final JunkSalesModel junkSales;
  CompleteOrders({this.courierModel, this.junkSales});
  @override
  _CompleteOrdersState createState() => _CompleteOrdersState();
}

class _CompleteOrdersState extends State<CompleteOrders> {
  List<TrashCartModel> listTrash;
  @override
  Widget build(BuildContext context) {
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadListTrash(widget.junkSales.id);
    listTrash = junkSalesProvider.listTrash;
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Pemesan'),
                      CustomText(
                          text: '${widget.junkSales.userName}',
                          size: 16.0,
                          weight: FontWeight.w600),
                      SizedBox(height: 16.0),
                      CustomText(text: 'Pengelola'),
                      CustomText(
                          text: '${widget.junkSales.businessName}',
                          size: 16.0,
                          weight: FontWeight.w600),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              CustomText(
                text: 'Rincian Sampah',
                weight: FontWeight.w700,
              ),
              SizedBox(height: 5.0),
              Card(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listTrash.length,
                  separatorBuilder: (_, index) => Divider(height: 0),
                  itemBuilder: (_, index) {
                    return ListTile(
                      dense: true,
                      leading: CustomText(
                        text: '${listTrash[index].weight} Kg',
                      ),
                      title: CustomText(
                        text: '${listTrash[index].name}',
                        size: 16.0,
                        weight: FontWeight.w600,
                      ),
                      trailing: CustomText(
                        text: NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(listTrash[index].price),
                        weight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Harga Sampah',
                          ),
                          CustomText(
                            text: NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 0)
                                .format(widget.junkSales.profitEstimate),
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Pendapatan',
                          ),
                          CustomText(
                            text: NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 0)
                                .format(widget.junkSales.deliveryCosts),
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Bayar tunai',
                          ),
                          CustomText(
                            text: NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 0)
                                .format(widget.junkSales.profitTotal),
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
