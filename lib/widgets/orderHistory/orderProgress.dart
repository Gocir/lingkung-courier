import 'package:flutter/material.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_courier/providers/userProvider.dart';
import 'package:lingkung_courier/providers/junkSalesProvider.dart';
import 'package:lingkung_courier/providers/partnerProvider.dart';

class OrderProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    final partnerProvider = Provider.of<PartnerProvider>(context);
    junkSalesProvider.loadJunkSalesOnProgress();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8.0),
      itemCount: junkSalesProvider.junkSalesOnProgress.length,
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => JunkSalesStatus(
            //         junkSalesId: junkSalesProvider.userJunkSales[index].id),
            //   ),
            // );
          },
          child: Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: CachedNetworkImage(
                imageUrl: junkSalesProvider
                    .junkSalesOnProgress[index].trashImage
                    .toString(),
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
                    text: 'Sedang Menerima',
                    color: green,
                    weight: FontWeight.w700,
                  ),
                  CustomText(
                    text: 'Loading...',
                    size: 16.0,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
