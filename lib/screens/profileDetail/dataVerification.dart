import 'package:flutter/material.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/screens/profileDetail/addProfile.dart';
import 'package:lingkung_courier/services/courierService.dart';
import 'package:lingkung_courier/screens/profileDetail/address/createAddress.dart';
import 'package:lingkung_courier/screens/profileDetail/addBankAccount.dart';
import 'package:lingkung_courier/screens/profileDetail/addDocument.dart';
import 'package:lingkung_courier/screens/profileDetail/accountStatus.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';

class DataVerification extends StatefulWidget {
  @override
  _DataVerificationState createState() => _DataVerificationState();
}

class _DataVerificationState extends State<DataVerification> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  CourierServices _courierService = CourierServices();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final courierProvider = Provider.of<CourierProvider>(context);
    return loading
        ? Loading()
        : SafeArea(
          top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                iconTheme: IconThemeData(color: black),
                automaticallyImplyLeading: false,
                title: CustomText(
                  text: 'Data Mitra Pengemudi',
                  size: 18.0,
                  weight: FontWeight.w600,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.help_outline,
                      color: black,
                    ),
                    onPressed: null,
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        isThreeLine: true,
                        leading: Icon(Icons.check_circle,
                            color:
                                (courierProvider.courierModel?.addressModel ==
                                        null)
                                    ? grey
                                    : blue),
                        title: CustomText(
                            text: 'Informasi Mitra Pengemudi',
                            weight: FontWeight.w700),
                        subtitle: CustomText(
                            text: (courierProvider.courierModel?.addressModel ==
                                    null)
                                ? 'Isi alamat rumah dan nomor Hp Anda.'
                                : 'Data sudah lengkap',
                            line: 2,
                            over: TextOverflow.ellipsis,
                            size: 12.0,
                            color: grey),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAddress(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        isThreeLine: true,
                        leading: Icon(Icons.check_circle,
                            color:
                                (courierProvider.courierModel?.documentModel ==
                                        null)
                                    ? grey
                                    : blue),
                        title: CustomText(
                          text: 'Dokumen Persyaratan',
                          weight: FontWeight.w700,
                        ),
                        subtitle: CustomText(
                            text: (courierProvider
                                        .courierModel?.documentModel ==
                                    null)
                                ? 'Unggah dokumen persyaratan yang dibutuhkan.'
                                : 'Data sudah lengkap',
                            size: 12.0,
                            color: grey),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddDocument(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        isThreeLine: true,
                        leading: Icon(Icons.check_circle,
                            color: (courierProvider
                                        .courierModel?.bankAccountModel ==
                                    null)
                                ? grey
                                : blue),
                        title: CustomText(
                            text: 'Informasi Rekening Bank',
                            weight: FontWeight.w700),
                        subtitle: CustomText(
                            text: (courierProvider
                                        .courierModel?.bankAccountModel ==
                                    null)
                                ? 'Masukkan nama bank dan nomor rekening usaha Anda.'
                                : 'Data sudah lengkap',
                            size: 12.0,
                            color: grey),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBankAccount(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        isThreeLine: true,
                        leading: Icon(Icons.check_circle,
                            color: (courierProvider.courierModel?.image == null)
                                ? grey
                                : blue),
                        title: CustomText(
                            text: 'Profil Pengemudi', weight: FontWeight.w700),
                        subtitle: CustomText(
                            text: (courierProvider.courierModel?.image == null)
                                ? 'Lengkapi profil Anda.'
                                : 'Data sudah lengkap',
                            size: 12.0,
                            color: grey),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProfile(),
                            ),
                          );
                        },
                      ),
                      ListTile(),
                    ],
                  ).toList(),
                ),
              ),
              bottomNavigationBar: Container(
                height: 77.0,
                color: white,
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: (courierProvider.courierModel?.addressModel == null ||
                          courierProvider.courierModel?.documentModel == null ||
                          courierProvider.courierModel?.bankAccountModel ==
                              null ||
                          courierProvider.courierModel?.image == null)
                      ? grey
                      : green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: CustomText(
                          text: 'KIRIM',
                          color: white,
                          size: 16.0,
                          weight: FontWeight.w700)),
                  onPressed: () async {
                    setState(() => loading = true);
                    if (courierProvider.courierModel?.addressModel == null ||
                        courierProvider.courierModel?.documentModel == null ||
                        courierProvider.courierModel?.bankAccountModel ==
                            null ||
                        courierProvider.courierModel?.image == null) {
                      _notCompleteBottomSheet(context);
                      setState(() => loading = false);
                    } else {
                      _courierService.updateCourier({
                        "uid": courierProvider.courier.uid,
                        "accountStatus": 'Verify',
                      });
                      setState(() => loading = false);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountStatus(),
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

  void _notCompleteBottomSheet(context) {
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
          child: Column(
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
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Data Anda belum lengkap. Lengkapi dulu, yuk.',
                      size: 18.0,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 45,
                      child: FlatButton(
                        color: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CustomText(
                            text: 'OKE',
                            color: white,
                            size: 16.0,
                            weight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
