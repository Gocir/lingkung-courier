import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';
//  Providers
import 'package:lingkung_courier/providers/courierProvider.dart';
//  Screens
import 'package:lingkung_courier/screens/authenticate/login.dart';
//  Utilities
import 'package:lingkung_courier/utilities/colorStyle.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final courierProvider = Provider.of<CourierProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarColor: yellow,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: yellow,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(-14.23, 22.85),
                      child:
                          // Adobe XD layer: 'grass1' (shape)
                          Container(
                        width: 118.0,
                        height: 115.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/grass111.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(150, -44.93),
                      child:
                          // Adobe XD layer: 'grass2' (shape)
                          Container(
                        width: 133.0,
                        height: 149.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/grass222.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 16.0,
                        top: 16.0,
                        right: 16.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: black.withOpacity(0.9),
                                        child: Center(
                                          child: Hero(
                                            tag: 'CourierImage',
                                            child: Image.network(
                                              courierProvider
                                                  .courierModel?.image
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Hero(
                                  tag: 'CourierImage',
                                  child: loading
                                      ? Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: SpinKitThreeBounce(
                                            color: black,
                                            size: 20.0,
                                          ),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: courierProvider
                                              .courierModel?.image
                                              .toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 70.0,
                                            height: 70.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              color: white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.0,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 70.0,
                                            height: 70.0,
                                            decoration: BoxDecoration(
                                              color: white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: SpinKitThreeBounce(
                                              color: black,
                                              size: 20.0,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            width: 70.0,
                                            height: 70.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/user.png"),
                                                fit: BoxFit.cover,
                                              ),
                                              color: white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                text: (courierProvider
                                            .courierModel?.courierName ==
                                        null)
                                    ? 'Hero Lingkung'
                                    : 'BS. ${courierProvider.courierModel?.courierName}',
                                over: TextOverflow.fade,
                                size: 18,
                                weight: FontWeight.w700,
                              ),
                              CustomText(
                                text: (courierProvider.courierModel?.email ==
                                        null)
                                    ? 'email@domain.hosting'
                                    : '${courierProvider.courierModel?.email}',
                                color: white,
                                size: 12,
                              ),
                              CustomText(
                                text:
                                    '${courierProvider.courier?.phoneNumber}' ??
                                        '',
                                color: white,
                                size: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 66.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 50.666),
                          CustomText(
                            text: 'Akun',
                            weight: FontWeight.w700,
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: [
                                  ListTile(
                                    leading: Image.asset(
                                        "assets/icons/wastetypeColor.png"),
                                    title: CustomText(
                                      text: 'Jenis Sampah',
                                      weight: FontWeight.w500,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: grey,
                                    ),
                                    dense: true,
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           TrashReceivePage(
                                      //               courierModel: courierProvider
                                      //                   .courierModel),
                                      //     ),);
                                    },
                                  ),
                                  ListTile(
                                    leading: Image.asset(
                                        "assets/icons/operationalColor.png"),
                                    title: CustomText(
                                      text: 'Jam Operasional',
                                      weight: FontWeight.w500,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: grey,
                                    ),
                                    dense: true,
                                    onTap: () {
                                      // timeProvider.loadOperationalTime();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => OperationalTime(
                                      //           courierModel: courierProvider
                                      //               .courierModel),
                                      //     ));
                                    },
                                  ),
                                  ListTile(
                                    leading: Image.asset(
                                        "assets/icons/performanceColor.png"),
                                    title: CustomText(
                                      text: 'Performa',
                                      weight: FontWeight.w500,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: grey,
                                    ),
                                    dense: true,
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           AddTrashReceivePage(),
                                      //     ));
                                    },
                                  ),
                                ],
                              ).toList(),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          CustomText(
                            text: 'Info lainnya',
                            weight: FontWeight.w700,
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: [
                                  ListTile(
                                    dense: true,
                                    leading: Image.asset(
                                        "assets/icons/helpsColor.png"),
                                    title: CustomText(
                                      text: 'Bantuan',
                                      weight: FontWeight.w500,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: grey,
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => HelpFeatureList(),
                                      //     ));
                                    },
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Image.asset(
                                        "assets/icons/contactColor.png"),
                                    title: CustomText(
                                      text: 'Hubungi Kami',
                                      weight: FontWeight.w500,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: grey,
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => ContactUs(),
                                      //     ));
                                    },
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Image.asset(
                                        "assets/icons/tosColor.png"),
                                    title: CustomText(
                                      text: 'Ketentuan Layanan',
                                      weight: FontWeight.w500,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: grey,
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => TermsOfService(),
                                      //     ));
                                    },
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Image.asset(
                                        "assets/icons/privacyColor.png"),
                                    title: CustomText(
                                      text: 'Kebijakan Privacy',
                                      weight: FontWeight.w500,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: grey,
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => PrivacyPolicy(),
                                      //     ));
                                    },
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: Image.asset(
                                        "assets/icons/phoneColor.png"),
                                    title: CustomText(
                                      text: 'Versi',
                                      weight: FontWeight.w500,
                                    ),
                                    trailing: CustomText(
                                      text: '1.1.1',
                                      color: grey,
                                      size: 12.0,
                                    ),
                                  ),
                                ],
                              ).toList(),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            height: 45.0,
                            child: RaisedButton(
                              color: green,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'KELUAR',
                                  size: 16.0,
                                  color: white,
                                  weight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () async {
                                await courierProvider.logout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100.0,
                  margin: EdgeInsets.only(
                    left: 16.0,
                    top: 106.0,
                    right: 16.0,
                  ),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 0),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset("assets/icons/balanceColor.png"),
                          CustomText(text: 'Saldo'),
                          CustomText(
                            text: NumberFormat.compactCurrency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 0)
                                .format((courierProvider
                                            .courierModel?.balance ==
                                        null)
                                    ? 0
                                    : courierProvider.courierModel?.balance),
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                      VerticalDivider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset("assets/icons/peopleColor.png"),
                          CustomText(text: 'Nasabah'),
                          CustomText(
                            text: NumberFormat.compactCurrency(
                                    locale: 'id', symbol: '', decimalDigits: 0)
                                .format((courierProvider
                                            .courierModel?.customer ==
                                        null)
                                    ? 0
                                    : courierProvider.courierModel?.customer),
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                      VerticalDivider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset("assets/icons/weightColor.png"),
                          CustomText(text: 'Sampah'),
                          CustomText(
                            text: NumberFormat.compactCurrency(
                                        locale: 'id',
                                        symbol: '',
                                        decimalDigits: 0)
                                    .format(
                                        (courierProvider.courierModel?.weight ==
                                                null)
                                            ? 0
                                            : courierProvider
                                                .courierModel?.weight) +
                                ' Kg',
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
