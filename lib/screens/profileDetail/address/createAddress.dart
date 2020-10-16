import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';
//  Models
import 'package:lingkung_courier/models/courierModel.dart';
import 'package:lingkung_courier/models/addressModel.dart';
//  Providers
import 'package:lingkung_courier/providers/courierProvider.dart';
//  Utilities
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';

class CreateAddress extends StatefulWidget {
  final AddressModel addressModel;
  final CourierModel courierModel;
  CreateAddress({this.addressModel, this.courierModel});
  @override
  _CreateAddressState createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String province = '';
  String city = '';
  String subDistrict = '';
  String postalCode = '';
  String addressDetail = '';
  String baseUrl = "http://192.168.10.232/news_server/index.php/Api/";
  String valProvince;
  String valCity;
  List<dynamic> dataProvince = List();
  List<dynamic> dataCity = List();

  @override
  Widget build(BuildContext context) {
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
                title: CustomText(
                  text: 'Atur Alamat',
                  size: 18.0,
                  weight: FontWeight.w700,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.help_outline_outlined,
                      color: black,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: 'Provinsi',
                        weight: FontWeight.w700,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: black,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.only(bottom: 8.0),
                          counterStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: black,
                          ),
                          hintText: 'Contoh: Jawa Barat',
                          hintStyle: TextStyle(fontFamily: "Poppins"),
                          errorStyle: TextStyle(fontFamily: "Poppins"),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blue),
                          ),
                        ),
                        onChanged: (str) {
                          setState(() {
                            province = str;
                          });
                        },
                        validator: (value) =>
                            (value.isEmpty) ? 'Masukkan nama provinsi' : null,
                      ),
                      SizedBox(height: 16.0),
                      CustomText(
                        text: 'Kota/Kabupaten',
                        weight: FontWeight.w700,
                      ),
                      TextFormField(
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: black,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.only(bottom: 8.0),
                            counterStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: black,
                            ),
                            hintText: 'Contoh: Kabupaten Bekasi',
                            hintStyle: TextStyle(fontFamily: "Poppins"),
                            errorStyle: TextStyle(fontFamily: "Poppins"),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blue),
                            ),
                          ),
                          onChanged: (str) {
                            setState(() {
                              city = str;
                            });
                          },
                          validator: (value) => (value.isEmpty)
                              ? 'Masukkan nama kota/kabupaten'
                              : null),
                      SizedBox(height: 16.0),
                      CustomText(
                        text: 'Kecamatan',
                        weight: FontWeight.w700,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: black,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.only(bottom: 8.0),
                          counterStyle:
                              TextStyle(fontFamily: "Poppins", color: black),
                          hintText: 'Contoh: Kecamatan Babelan',
                          hintStyle: TextStyle(fontFamily: "Poppins"),
                          errorStyle: TextStyle(fontFamily: "Poppins"),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blue),
                          ),
                        ),
                        onChanged: (str) {
                          setState(() {
                            subDistrict = str;
                          });
                        },
                        validator: (value) =>
                            (value.isEmpty) ? 'Masukkan nama kecamatan' : null,
                      ),
                      SizedBox(height: 16.0),
                      CustomText(
                        text: 'Kode POS',
                        weight: FontWeight.w700,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: black,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.only(bottom: 8.0),
                          counterStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: black,
                          ),
                          hintText: 'Contoh: 17510',
                          hintStyle: TextStyle(fontFamily: "Poppins"),
                          errorStyle: TextStyle(fontFamily: "Poppins"),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blue),
                          ),
                        ),
                        onChanged: (str) {
                          setState(() {
                            postalCode = str;
                          });
                        },
                        validator: (value) => (value.isEmpty)
                            ? 'Masukkan kode POS'
                            : (value.length > 5)
                                ? 'Batas Maksimal karakter adalah 5'
                                : null,
                      ),
                      SizedBox(height: 16.0),
                      CustomText(
                        text: 'Alamat Detail',
                        weight: FontWeight.w700,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: black,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.only(bottom: 8.0),
                          counterStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: black,
                          ),
                          hintText: 'Contoh: Nama gedung, jalan & lainnya...',
                          hintStyle: TextStyle(fontFamily: "Poppins"),
                          errorStyle: TextStyle(fontFamily: "Poppins"),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blue),
                          ),
                        ),
                        onChanged: (str) {
                          setState(() {
                            addressDetail = str;
                          });
                        },
                        validator: (value) =>
                            (value.isEmpty) ? 'Masukkan detail alamat' : null,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                width: MediaQuery.of(context).size.width,
                height: 80.0,
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CustomText(
                    text: 'SIMPAN',
                    color: white,
                    weight: FontWeight.w700,
                  ),
                  onPressed: () {
                    save();
                  },
                ),
              ),
            ),
          );
  }

  void save() async {
    final courierProvider =
        Provider.of<CourierProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      await courierProvider.createAddress(
        province: province,
        city: city,
        subDistrict: subDistrict,
        postalCode: int.parse(postalCode),
        addressDetail: addressDetail,
      );

      print("Address Saved!");
      _scaffoldStateKey.currentState.showSnackBar(
        SnackBar(
          content: CustomText(
            text: "Saved!",
            color: white,
            weight: FontWeight.w600,
          ),
        ),
      );
      courierProvider.reloadCourierModel();
      setState(() => loading = false);
      Navigator.pop(context);
    } else {
      print("Address failed to Save!");
      setState(() => loading = false);
    }
  }
}
