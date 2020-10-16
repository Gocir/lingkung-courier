import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
//  Content
import 'package:lingkung_courier/contents/textInfoContent.dart';
//  Utilities
import 'package:lingkung_courier/utilities/colorStyle.dart';
//  Widgets
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:lingkung_courier/widgets/webView.dart';

class TextInfoNewsList extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());
  @override
  _TextInfoNewsListState createState() => _TextInfoNewsListState();
}

class _TextInfoNewsListState extends State<TextInfoNewsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemCount: textInfoNews.length,
        itemBuilder: (_, index) {
          return InkWell(
              onTap: () async {
                await widget.browser.open(
                    url: textInfoNews[index].linkUrl.toString(),
                    options: ChromeSafariBrowserClassOptions(
                        android: AndroidChromeCustomTabsOptions(
                            addDefaultShareMenuItem: false)));
              },
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: textInfoNews[index].imageUrl.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      width: 110.0,
                                      height: 90.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 3.0)
                                          ])),
                              placeholder: (context, url) => Container(
                                  width: 110.0,
                                  height: 90.0,
                                  child: SpinKitThreeBounce(
                                      color: black, size: 10.0)),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/noimage.png"),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                  CustomText(
                                    text: textInfoNews[index].name,
                                    line: 3,
                                    over: TextOverflow.ellipsis,
                                    weight: FontWeight.w700,
                                  ),
                                  CustomText(
                                    text:
                                        'Sumber: ${textInfoNews[index].source}',
                                    size: 12.0,
                                    line: 1,
                                    over: TextOverflow.fade,
                                  ),
                                ]))
                          ]))));
        });
  }
}
