import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_courier/contents/videoInfoContent.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lingkung_courier/widgets/webView.dart';

class VideoInfoTutoriaList extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());
  @override
  _VideoInfoTutoriaListState createState() => _VideoInfoTutoriaListState();
}

class _VideoInfoTutoriaListState extends State<VideoInfoTutoriaList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemCount: videoInfoTutorial.length,
        itemBuilder: (_, index) {
          return InkWell(
              onTap: () async {
                await widget.browser.open(
                    url: videoInfoTutorial[index].linkUrl.toString(),
                    options: ChromeSafariBrowserClassOptions(
                        android: AndroidChromeCustomTabsOptions(
                            addDefaultShareMenuItem: false)));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl:
                              videoInfoTutorial[index].imageUrl.toString(),
                          imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ))),
                          placeholder: (context, url) => Container(
                              height: 180.0,
                              child:
                                  SpinKitThreeBounce(color: black, size: 20)),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/noimage.png"),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                    text: videoInfoTutorial[index].name,
                                    line: 2,
                                    over: TextOverflow.ellipsis,
                                    weight: FontWeight.w700,
                                  ),
                                  CustomText(
                                    text:
                                        'Sumber: ${videoInfoTutorial[index].source}',
                                    size: 12.0,
                                    line: 1,
                                    over: TextOverflow.fade,
                                  )
                                ]))
                      ])));
        });
  }
}
