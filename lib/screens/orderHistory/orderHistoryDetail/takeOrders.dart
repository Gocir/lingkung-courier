import 'package:flutter/material.dart';
import 'package:lingkung_courier/models/courierModel.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:lingkung_courier/providers/partnerProvider.dart';
import 'package:lingkung_courier/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:lingkung_courier/services/junkSalesService.dart';
import 'package:lingkung_courier/main.dart';
import 'package:lingkung_courier/screens/manipulateListTrash.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:lingkung_courier/models/trashCartModel.dart';
import 'package:lingkung_courier/screens/orderHistory/orderHistoryDetail/receiveOrders.dart';
import 'package:lingkung_courier/screens/orderHistory/orderHistoryDetail/deliverOrders.dart';

class TakeOrders extends StatefulWidget {
  final CourierModel courierModel;
  final JunkSalesModel junkSales;
  TakeOrders({this.courierModel, this.junkSales});
  @override
  _TakeOrdersState createState() => _TakeOrdersState();
}

class _TakeOrdersState extends State<TakeOrders> {
  JunkSalesServices _junkSalesService = JunkSalesServices();

  List<TrashCartModel> listTrash;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.loadSingleUser(widget.junkSales.userId);
    final partnerProvider = Provider.of<PartnerProvider>(context);
    partnerProvider.loadSinglePartner(widget.junkSales.partnerId);
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadSingleJunkSales(widget.junkSales.id);
    junkSalesProvider.loadListTrash(widget.junkSales.id);
    listTrash = junkSalesProvider.listTrash;
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: white,
                elevation: 0,
                iconTheme: IconThemeData(color: black),
                automaticallyImplyLeading: false,
                title: Image.asset('assets/images/logos.png', height: 35.0),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          leading: (userProvider.userModel?.image == null)
                              ? CircleAvatar(
                                    maxRadius: 16.0,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage:
                                        AssetImage("assets/images/user.png"),
                                  )
                              : CachedNetworkImage(
                                  imageUrl:
                                      userProvider.userModel?.image.toString(),
                                  imageBuilder: (_, imageProvider) =>
                                      CircleAvatar(
                                          maxRadius: 16.0,
                                          backgroundImage: imageProvider),
                                  placeholder: (_, url) => CircleAvatar(
                                    maxRadius: 16.0,
                                    backgroundColor: Colors.grey[200],
                                    child: SpinKitThreeBounce(
                                      color: black,
                                      size: 10.0,
                                    ),
                                  ),
                                  errorWidget: (_, url, error) => CircleAvatar(
                                    maxRadius: 16.0,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage:
                                        AssetImage("assets/images/user.png"),
                                  ),
                                ),
                          title: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Dipesan oleh\n',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12.0,
                                    color: black,
                                  ),
                                ),
                                TextSpan(
                                  text: '${userProvider.userModel?.name}',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16.0,
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: CustomText(
                            text:
                                '${widget.junkSales.directionModel.startPoint}',
                            size: 12.0,
                            color: grey,
                          ),
                          trailing: IconButton(
                            icon: Icon(CupertinoIcons.chat_bubble_text,
                                color: black),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomText(
                                    text: 'Rincian Sampah',
                                    weight: FontWeight.w700,
                                  ),
                                  InkWell(
                                    child: CustomText(
                                      text: 'Ubah',
                                      color: green,
                                      size: 12.0,
                                      weight: FontWeight.w600,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ManipulateListTrash(
                                                  junkSales: widget.junkSales,
                                                  listTrash: listTrash),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 5.0),
                              ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: listTrash.length,
                                separatorBuilder: (_, index) =>
                                    Divider(height: 0),
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomText(
                                    text: 'Harga Sampah',
                                  ),
                                  CustomText(
                                    text: NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp',
                                            decimalDigits: 0)
                                        .format((junkSalesProvider
                                                    .junkSalesModel
                                                    ?.profitEstimate ==
                                                null)
                                            ? 0
                                            : junkSalesProvider.junkSalesModel
                                                ?.profitEstimate),
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomText(
                                    text: 'Pendapatan',
                                  ),
                                  CustomText(
                                    text: NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp',
                                            decimalDigits: 0)
                                        .format((junkSalesProvider
                                                    .junkSalesModel
                                                    ?.deliveryCosts ==
                                                null)
                                            ? 0
                                            : junkSalesProvider
                                                .junkSalesModel?.deliveryCosts),
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomText(
                                    text: 'Bayar tunai',
                                  ),
                                  CustomText(
                                    text: NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp',
                                            decimalDigits: 0)
                                        .format((junkSalesProvider
                                                    .junkSalesModel
                                                    ?.profitTotal ==
                                                null)
                                            ? 0
                                            : junkSalesProvider
                                                .junkSalesModel?.profitTotal),
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 70.0,
                              child: FlatButton(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: (junkSalesProvider.junkSalesModel
                                                      ?.profitTotal ==
                                                  null ||
                                              junkSalesProvider.junkSalesModel
                                                  .profitTotal.isNegative)
                                          ? Colors.red
                                          : grey,
                                    ),
                                    CustomText(
                                        text: 'Batalkan',
                                        color: (junkSalesProvider.junkSalesModel
                                                        ?.profitTotal ==
                                                    null ||
                                                junkSalesProvider.junkSalesModel
                                                    .profitTotal.isNegative)
                                            ? black
                                            : grey),
                                  ],
                                ),
                                onPressed: () {
                                  if (junkSalesProvider
                                              .junkSalesModel?.profitTotal ==
                                          null ||
                                      junkSalesProvider.junkSalesModel
                                          .profitTotal.isNegative) {
                                    _cancelOrdersBottomSheet(context);
                                  } else {
                                    print(
                                        'sementara pesan tidak bisa di cancel');
                                  }
                                },
                              ),
                            ),
                            VerticalDivider(
                              indent: 3.0,
                              endIndent: 3.0,
                            ),
                            Container(
                              height: 70.0,
                              child: FlatButton(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Icon(Icons.help_outline),
                                    CustomText(text: 'Bantuan'),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: 80.0,
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: CustomText(
                      text: 'Mulai pengantaran',
                      size: 16.0,
                      color: white,
                      weight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    _takeOrdersModalBottomSheet(context);
                  },
                ),
              ),
            ),
          );
  }

  void deliverOrders() async {
    final junkSales = Provider.of<JunkSalesProvider>(context, listen: false);
    final courier = Provider.of<CourierProvider>(context, listen: false);
    junkSales.loadSingleJunkSales(widget.junkSales.id);
    await junkSales.updateJunkSales(
      status: "Deliver Orders",
      courierId: courier.courierModel.id,
      courierName: courier.courierModel.courierName,
      junkSalesModel: junkSales.junkSalesModel,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DeliverOrders(
          courierModel: widget.courierModel,
          junkSales: junkSales.junkSalesModel,
        ),
      ),
    );
  }

  void _takeOrdersModalBottomSheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 186.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Sudah ambil sampahnya?',
                  size: 22.0,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 10.0),
                CustomText(
                  text:
                      'Sebelum menekan tombol, pastikan sampahnya udah sama Anda, ya.',
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: OutlineButton(
                          color: white,
                          highlightColor: white,
                          highlightedBorderColor: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: blue,
                            width: 1.5,
                          ),
                          child: CustomText(
                            text: 'BELUM',
                            color: blue,
                            size: 16.0,
                            weight: FontWeight.w700,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          color: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            text: 'SUDAH',
                            color: white,
                            size: 16.0,
                            weight: FontWeight.w700,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            deliverOrders();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void cancel() async {
    final salesProvider = Provider.of<JunkSalesProvider>(
      context,
      listen: false,
    );
    salesProvider.loadSingleJunkSales(widget.junkSales.id);
    salesProvider.loadListTrash(widget.junkSales.id);
    setState(() {
      loading = true;
    });

    for (int i = 0; i < salesProvider.listTrash.length; i++) {
      await _junkSalesService.deleteListTrash(
          junkSalesId: widget.junkSales.id,
          trashItemId: salesProvider.listTrash[i].id);
    }
    print("LIST TRASH '${salesProvider.listTrash.toString()}' WAS DELETED");

    await salesProvider.deleteJunkSales(junkSalesId: widget.junkSales.id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
    setState(() {
      loading = false;
    });
  }

  void _cancelOrdersBottomSheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 2.2,
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/verifailed.png"),
                  ),
                  SizedBox(height: 16.0),
                  CustomText(
                    text: 'Yahh! Kamu yakin ingin membatalkan pesanan ini?',
                    size: 18.0,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 48,
                          child: OutlineButton(
                            color: blue,
                            highlightedBorderColor: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            borderSide: BorderSide(
                              color: blue,
                              width: 2.5,
                            ),
                            child: CustomText(
                              text: 'TIDAK',
                              color: blue,
                              size: 16.0,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Container(
                          height: 48,
                          child: FlatButton(
                            color: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: CustomText(
                              text: 'YA',
                              color: white,
                              size: 16.0,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              cancel();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
