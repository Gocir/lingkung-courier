import 'package:flutter/material.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/models/trashCartModel.dart';
import 'package:lingkung_courier/models/trashReceiveModel.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:lingkung_courier/providers/trashReceiveProvider.dart';
import 'package:lingkung_courier/widgets/trashCartCard.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_courier/services/junkSalesService.dart';

class ManipulateListTrash extends StatefulWidget {
  final JunkSalesModel junkSales;
  final List<TrashCartModel> listTrash;
  ManipulateListTrash({this.junkSales, this.listTrash});
  @override
  _ManipulateListTrashState createState() => _ManipulateListTrashState();
}

class _ManipulateListTrashState extends State<ManipulateListTrash> {
  JunkSalesServices _junkSalesService = JunkSalesServices();

  List<TrashReceiveModel> trash;
  List<TrashCartModel> listTrash;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final _scaffoldStateKey = GlobalKey<ScaffoldState>();

    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadListTrash(widget.junkSales.id);
    junkSalesProvider.getProfit(widget.junkSales.id);

    final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context);
    trashReceiveProvider.loadTrashReceiveByPartner(widget.junkSales.partnerId);
    trash = trashReceiveProvider.trashReceiveByPartner;
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              appBar: AppBar(
                backgroundColor: white,
                elevation: 1.5,
                iconTheme: IconThemeData(color: black),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () async {
                    setState(() {
                      loading= true;
                    });
                    await junkSalesProvider.updateProfit(
                      junkSalesId: widget.junkSales.id,
                      profit: junkSalesProvider.profit,
                      profitTotal: junkSalesProvider.profit - 6100
                    );
                    junkSalesProvider.loadJunkSalesOrders();
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                  },
                ),
                title: CustomText(
                  text: 'Perbarui Sampah',
                  size: 18.0,
                  color: black,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: 'Rincian Sampah',
                          weight: FontWeight.w700,
                        ),
                        InkWell(
                          child: CustomText(
                            text: 'Tambah',
                            color: blue,
                            size: 12.0,
                            weight: FontWeight.w600,
                          ),
                          onTap: () {
                            _addTrashModalBottomSheet(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: junkSalesProvider.listTrash.length,
                        separatorBuilder: (_, index) => Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        itemBuilder: (_, index) {
                          TrashCartModel itemCart =
                              junkSalesProvider.listTrash[index];
                          return TrashCartCard(
                            junkSales: widget.junkSales,
                            itemCart: itemCart,
                            scaffold: _scaffoldStateKey,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        color: Colors.grey[100],
                      ),
                      child: ListTile(
                        dense: true,
                        title: CustomText(
                          text: 'Total Harga',
                          weight: FontWeight.w600,
                        ),
                        trailing: CustomText(
                          text: NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp', decimalDigits: 0)
                              .format(junkSalesProvider.profit),
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void _addTrashModalBottomSheet(context) {
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
                text: 'BS. ${widget.junkSales.businessName}',
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
                padding: const EdgeInsets.all(16.0),
                itemCount: trash.length,
                separatorBuilder: (_, index) => Divider(),
                itemBuilder: (_, index) {
                  return ListTile(
                    dense: true,
                    onTap: () {
                      addTrash(trash[index]);
                    },
                    leading: CachedNetworkImage(
                      imageUrl: trash[index].image.toString(),
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
                        backgroundImage:
                            AssetImage("assets/images/noimage.png"),
                      ),
                    ),
                    title: CustomText(
                      text: '${trash[index].trashName}',
                    ),
                    trailing: CustomText(
                      text: NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(trash[index].price),
                      weight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void addTrash(TrashReceiveModel item) async {
    final junkSalesProvider =
        Provider.of<JunkSalesProvider>(context, listen: false);

    listTrash = await _junkSalesService.getListTrashByReceive(
        junkSalesId: widget.junkSales.id, trashReceiveId: item.id);

    if (listTrash.isEmpty) {
      junkSalesProvider.addListTrash(
        junkSalesId: widget.junkSales.id,
        item: item,
      );
      print('saved!');
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      print('Already');
      print(item);
      return;
    }
  }
}
