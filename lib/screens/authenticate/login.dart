import 'package:country_code_picker/country_code_picker.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/screens/authenticate/register.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String dialCode;
  String smsCode;
  String verificationId;
  String errorMessage;
  String phoneNumber;
  String phoneNumberLogin;
  bool loading = false;

  void _onCountryChange(CountryCode countryCode) {
    //T0D0 : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    setState(() {
      dialCode = countryCode.toString();
    });
  }

  void _onInitCountry(CountryCode countryCode) {
    //T0D0 : manipulate the selected country code here
    print("on init ${countryCode.dialCode} ${countryCode.name}");
    dialCode = countryCode.toString();
    print(dialCode);
  }

  void _phoneNumberChange(String number) {
    //T0D0 : manipulate the selected country code here
    // print("phoneNumber is ${number.toString()}");
    phoneNumber = dialCode + number;
  }

  @override
  Widget build(BuildContext context) {
    final courierProvider = Provider.of<CourierProvider>(context);
    courierProvider.loadUserByPhone(phoneNumber);
    return SafeArea(
        top: false,
        child: Scaffold(
            key: _scaffoldStateKey,
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0,
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
              actions: [
                IconButton(
                  icon: Icon(Icons.help_outline, color: black),
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: <Widget>[
                      Image.asset('assets/images/otentikasi.png',
                          alignment: Alignment.bottomCenter),
                      SizedBox(height: 30.0),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomText(
                                text: 'Selamat Datang di Lingcou!',
                                size: 20.0,
                                weight: FontWeight.w700),
                            SizedBox(height: 10.0),
                            CustomText(
                                text:
                                    'Angkut sampah masyarakat sesuai pesanan.'),
                            SizedBox(height: 16.0),
                            Form(
                              key: _formKey,
                              child: Row(children: <Widget>[
                                Container(
                                    width: 70.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[200],
                                    ),
                                    child: CountryCodePicker(
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        onChanged: (countryCode) {
                                          _onCountryChange(countryCode);
                                        },
                                        initialSelection: 'ID',
                                        favorite: ['ID'],
                                        // optional. Shows only country name and flag
                                        showCountryOnly: true,
                                        // optional. Shows only country name and flag when popup is closed
                                        showOnlyCountryWhenClosed: false,
                                        // optional. aligns the flag and the Text left
                                        alignLeft: false,
                                        onInit: (countryCode) {
                                          _onInitCountry(countryCode);
                                        },
                                        searchDecoration: InputDecoration(
                                            isDense: true,
                                            prefixIcon: Icon(Icons.search),
                                            hintText: 'Ketik nama negara',
                                            hintStyle: TextStyle(
                                              fontFamily: "Poppins",
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                borderSide:
                                                    BorderSide(color: blue))),
                                        searchStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            color: black,
                                            fontSize: 16.0),
                                        textStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            color: black),
                                        dialogTextStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            color: black,
                                            fontSize: 16.0))),
                                SizedBox(width: 10.0),
                                Flexible(
                                    flex: 2,
                                    child: TextFormField(
                                        controller:
                                            courierProvider.phoNumberLogin,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          LengthLimitingTextInputFormatter(11),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: black),
                                        decoration: InputDecoration(
                                            isDense: true,
                                            counterStyle: TextStyle(
                                                fontFamily: "Poppins",
                                                color: black),
                                            hintText: 'Contoh: 81234567890',
                                            hintStyle: TextStyle(
                                              fontFamily: "Poppins",
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: blue))),
                                        onChanged: (String str) {
                                          _phoneNumberChange(str);
                                        },
                                        validator: (value) => (value.isEmpty)
                                            ? 'Masukkan Nomor Ponsel-mu'
                                            : (value.length > 11 ||
                                                    value.length < 11)
                                                ? 'Batas Maksimal Nomor Ponsel adalah 11'
                                                : null))
                              ]),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45.0,
                                child: FlatButton(
                                    color: green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: CustomText(
                                        text: "MASUK",
                                        color: white,
                                        weight: FontWeight.w700),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });

                                        // bool value = courierProvider.courierByPhone.isEmpty;
                                        print(phoneNumber);
                                        // print(value);

                                        if (courierProvider
                                            .courierByPhone.isEmpty) {
                                          setState(() {
                                            _scaffoldStateKey.currentState
                                                .showSnackBar(SnackBar(
                                                    content: CustomText(
                                              text:
                                                  "Nomor Anda Belum Terdaftar, Silahkan Daftar!",
                                              color: white,
                                              weight: FontWeight.w600,
                                            )));
                                            loading = false;
                                            courierProvider.clearController();
                                          });
                                        } else {
                                          courierProvider.verify(
                                              context,
                                              phoneNumber,
                                              courierProvider.courierName.text,
                                              courierProvider.email.text);
                                        }
                                      }
                                    })),
                            SizedBox(height: 10.0),
                            Center(
                                child: CustomText(
                                    text: 'Atau', weight: FontWeight.w600)),
                            SizedBox(height: 10.0),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45.0,
                                child: FlatButton(
                                    color: white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: green, width: 2.0)),
                                    child: CustomText(
                                        text: "DAFTAR",
                                        color: green,
                                        weight: FontWeight.w700),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage()));
                                    }))
                          ])
                    ])))));
  }
}
