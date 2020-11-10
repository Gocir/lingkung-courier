import 'package:flutter/material.dart';
import 'package:lingkung_courier/models/courierModel.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/models/trashCartModel.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lingkung_courier/main.dart';
import 'package:lingkung_courier/services/junkSalesService.dart';
import 'package:lingkung_courier/screens/orderHistory/orderHistoryDetail/takeOrders.dart';

class ReceiveOrders extends StatefulWidget {
  final CourierModel courierModel;
  final JunkSalesModel junkSales;
  ReceiveOrders({this.courierModel, this.junkSales});
  @override
  _ReceiveOrdersState createState() => _ReceiveOrdersState();
}

class _ReceiveOrdersState extends State<ReceiveOrders> {
  JunkSalesServices _junkSalesService = JunkSalesServices();

  List<TrashCartModel> listTrash;
  int totalWeight = 0;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.loadSingleUser(widget.junkSales.userId);
    final partnerProvider = Provider.of<PartnerProvider>(context);
    partnerProvider.loadSinglePartner(widget.junkSales.partnerId);
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadListTrash(widget.junkSales.id);
    junkSalesProvider.getTotalWeight(widget.junkSales.id);
    listTrash = junkSalesProvider.listTrash;
    totalWeight = junkSalesProvider.totalWeight;

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
                        child:
                            ListTile(
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
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: const EdgeInsets.all(8.0),
                              leading: (partnerProvider.partnerModel?.image ==
                                      null)
                                  ? CircleAvatar(
                                      maxRadius: 16.0,
                                      backgroundColor: Colors.grey[200],
                                      child: SpinKitThreeBounce(
                                        color: black,
                                        size: 10.0,
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: partnerProvider
                                          .partnerModel?.image
                                          .toString(),
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
                                      errorWidget: (_, url, error) =>
                                          CircleAvatar(
                                        maxRadius: 16.0,
                                        backgroundColor: Colors.grey[200],
                                        backgroundImage: AssetImage(
                                            "assets/images/noimage.png"),
                                      ),
                                    ),
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Antar ke\n',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12.0,
                                        color: black,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'BS. ${partnerProvider.partnerModel?.businessName}',
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
                                    '${widget.junkSales.directionModel.destination}',
                                color: grey,
                                size: 12.0,
                              ),
                            ),
                            Divider(
                              indent: 70.0,
                              endIndent: 10.0,
                              height: 0,
                            ),
                            IntrinsicHeight(
                              child: ButtonBar(
                                mainAxisSize: MainAxisSize.max,
                                alignment: MainAxisAlignment.spaceEvenly,
                                buttonPadding: const EdgeInsets.all(0),
                                children: <Widget>[
                                  SizedBox(width: 45.0),
                                  FlatButton.icon(
                                    icon: Icon(
                                      CupertinoIcons.phone,
                                      color: black,
                                    ),
                                    label: CustomText(
                                      text: 'Telepon',
                                      size: 12.0,
                                    ),
                                    onPressed: () {},
                                  ),
                                  VerticalDivider(
                                    indent: 3.0,
                                    endIndent: 3.0,
                                  ),
                                  FlatButton.icon(
                                    icon:
                                        FaIcon(FontAwesomeIcons.dumpster, color: black),
                                    label: CustomText(
                                      text: 'Pesanan',
                                      size: 12.0,
                                    ),
                                    onPressed: () {
                                      _trashDetailBottomSheet(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                                        .format(
                                            widget.junkSales.profitEstimate),
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
                                        .format(widget.junkSales.deliveryCosts),
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
                                        .format(widget.junkSales.profitTotal),
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
                                      color: Colors.red,
                                    ),
                                    CustomText(text: 'Batalkan'),
                                  ],
                                ),
                                onPressed: () {
                                  _cancelOrdersBottomSheet(context);
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
                      text: 'Sudah di tempat pemesan',
                      size: 16.0,
                      color: white,
                      weight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    takeOrders();
                  },
                ),
              ),
            ),
          );
  }

  void _trashDetailBottomSheet(context) {
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
          children: <Widget>[
            ListTile(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close, color: black),
              ),
              title: CustomText(
                text: 'Rincian Sampah',
                color: black,
                size: 18.0,
                weight: FontWeight.w600,
              ),
            ),
            Divider(
              indent: 16.0,
              endIndent: 16.0,
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(32.0),
                itemCount: listTrash.length,
                separatorBuilder: (_, index) => Divider(),
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
            Container(
              margin: const EdgeInsets.all(16.0),
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
                        text: "Total berat",
                        weight: FontWeight.w600,
                      ),
                      CustomText(
                          text: '${totalWeight.toString()} Kg',
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
                        text: "Harga (Estimasi)",
                        weight: FontWeight.w600,
                      ),
                      CustomText(
                        text: NumberFormat.currency(
                                locale: 'id', symbol: 'Rp', decimalDigits: 0)
                            .format(widget.junkSales.profitEstimate),
                        size: 16.0,
                        weight: FontWeight.w700,
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

  void takeOrders() async {
    final junkSales = Provider.of<JunkSalesProvider>(context, listen: false);
    final courier = Provider.of<CourierProvider>(context, listen: false);

    await junkSales.updateJunkSales(
      status: "Take Orders",
      courierId: courier.courierModel.id,
      courierName: courier.courierModel.courierName,
      junkSalesModel: widget.junkSales,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TakeOrders(junkSales: widget.junkSales, courierModel: widget.courierModel,),
      ),
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
