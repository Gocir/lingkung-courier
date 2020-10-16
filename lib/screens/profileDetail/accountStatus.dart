import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lingkung_courier/main.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/screens/authenticate/login.dart';
import 'package:lingkung_courier/services/courierService.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_courier/screens/profileDetail/dataVerification.dart';

class AccountStatus extends StatefulWidget {
  final String phoneNumber;
  AccountStatus({this.phoneNumber});
  @override
  _AccountStatusState createState() => _AccountStatusState();
}

class _AccountStatusState extends State<AccountStatus> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  CourierServices _courierService = CourierServices();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final courierProvider = Provider.of<CourierProvider>(context);
    courierProvider.loadUserById(courierProvider.courierModel?.id);
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                elevation: 1.5,
                iconTheme: IconThemeData(color: black),
                automaticallyImplyLeading: false,
                title: (courierProvider.courierModel?.courierName == null &&
                        courierProvider.courierModel?.addressModel == null)
                    ? CustomText(text: 'Tunggu, sedang memuat ...')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text:
                                '${courierProvider.courierModel?.courierName}',
                            size: 18.0,
                            weight: FontWeight.w600,
                          ),
                          CustomText(
                            text:
                                '${courierProvider.courierModel?.addressModel?.city}',
                            size: 12.0,
                            color: grey,
                          ),
                        ],
                      ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.help_outline,
                        color: black,
                      ),
                      onPressed: null),
                  PopupMenuButton(
                    offset: Offset(0, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: InkWell(
                            onTap: () async {
                              await courierProvider.logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: yellow,
                                ),
                                SizedBox(width: 5.0),
                                CustomText(text: 'Keluar')
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment:
                      (courierProvider.courierModel?.accountStatus == "Verify")
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        (courierProvider.courierModel?.accountStatus ==
                                "Verify")
                            ? "assets/images/verifyAccount.png"
                            : (courierProvider.courierModel?.accountStatus ==
                                    "Verification Failed")
                                ? "assets/images/verifailed.png"
                                : "assets/images/activateAccount.png",
                        height: 250.0,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          right: 55.0,
                          top: 11.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: LinearProgressIndicator(
                              minHeight: 5.0,
                              backgroundColor: grey,
                              value: (courierProvider
                                          .courierModel?.accountStatus ==
                                      "Verified")
                                  ? 1.0
                                  : 0.55,
                              valueColor: AlwaysStoppedAnimation<Color>(blue),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: [
                                FaIcon(FontAwesomeIcons.solidCheckCircle,
                                    color: blue),
                                SizedBox(height: 10.0),
                                CustomText(
                                  text: 'Pendaftaran',
                                  size: 12.0,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                (courierProvider.courierModel?.accountStatus ==
                                        "Verified")
                                    ? Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: white,
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidCheckCircle,
                                          color: blue,
                                        ),
                                      )
                                    : Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: white,
                                            width: 8.0,
                                          ),
                                          color: blue,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                SizedBox(height: 10.0),
                                CustomText(
                                  text: 'Verifikasi',
                                  size: 12.0,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                (courierProvider.courierModel?.accountStatus ==
                                        "Verified")
                                    ? Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: white,
                                            width: 8.0,
                                          ),
                                          color: blue,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          CupertinoIcons.circle_filled,
                                          color: white,
                                        ),
                                      ),
                                SizedBox(height: 10.0),
                                CustomText(
                                  text: 'Aktivasi',
                                  size: 12.0,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                (courierProvider.courierModel?.accountStatus ==
                                        "Verify")
                                    ? 'Data sedang di verifikasi\n'
                                    : (courierProvider
                                                .courierModel?.accountStatus ==
                                            "Verification Failed")
                                        ? 'Perbaiki dulu data pribadimu, ya\n'
                                        : 'Hore! Datamu disetujui\n',
                            style: TextStyle(
                              color: black,
                              fontSize: 18.0,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: (courierProvider
                                        .courierModel?.accountStatus ==
                                    "Verify")
                                ? 'Mohon datang ke kantor Karo Lingkung dengan membawa berkas persyaratan yang diminta untuk melanjutkan verifikasi.'
                                : (courierProvider
                                            .courierModel?.accountStatus ==
                                        "Verification Failed")
                                    ? 'Kami menemukan ketidakcocokan dalam data yang kamu kirim. Mohon perbaiki dulu, lalu kirim ulang.'
                                    : 'Yuk lanjut aktifkan akun-mu untuk mulai menerima pesanan penjemputan sampah.',
                            style: TextStyle(
                              color: black,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                    (courierProvider.courierModel?.accountStatus == "Verify")
                        ? Container(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              bottom: 5.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Colors.grey[200],
                                width: 1.5,
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.local_shipping,
                                color: blue,
                              ),
                              title: CustomText(
                                text:
                                    'Cek data yang harus disiapkan untuk pengajuan akun-mu di kantor Karo Lingkung, yuk!',
                                size: 12.0,
                                weight: FontWeight.w600,
                              ),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              bottomNavigationBar:
                  (courierProvider.courierModel?.accountStatus == "Verify")
                      ? null
                      : Container(
                          height: 80.0,
                          color: white,
                          padding: const EdgeInsets.all(16.0),
                          child: FlatButton(
                            color: green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: CustomText(
                                text: (courierProvider
                                            .courierModel?.accountStatus ==
                                        "Verification Failed")
                                    ? 'Perbaiki data usaha'
                                    : 'LANJUT',
                                color: white,
                                size: 16.0,
                                weight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {
                              if (courierProvider.courierModel?.accountStatus ==
                                  "Verification Failed") {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DataVerification(),
                                  ),
                                );
                              } else {
                                setState(() => loading = true);
                                _courierService.updateCourier({
                                  "uid": courierProvider.courier.uid,
                                  "accountStatus": 'Activated',
                                });
                                print('account activated!');
                                setState(() => loading = false);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(),
                                  ),
                                );
                                courierProvider.reloadCourierModel();
                              }
                            },
                          ),
                        ),
            ),
          );
  }
}
