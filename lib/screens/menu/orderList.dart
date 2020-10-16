import 'package:flutter/material.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
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
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          itemCount: junkSalesProvider.junkSales.length,
          itemBuilder: (_, index) {
            return Card(
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: junkSalesProvider.junkSales[index].trashImage.toString(),
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
                  text: '${junkSalesProvider.junkSales[index].id}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
