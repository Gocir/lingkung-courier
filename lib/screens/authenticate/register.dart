import 'package:country_code_picker/country_code_picker.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String dialCode;
  String smsCode;
  String verificationId;
  String errorMessage;
  String phoneNumber;
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
                    title: CustomText(
                        text: 'Buat Akun', size: 18.0, weight: FontWeight.w600),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline),
                          onPressed: () {
                            // Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => HelpRegisterList(),
                            //       ));
                          })
                    ]),
                body: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                      text: 'Nama Pengguna',
                                      weight: FontWeight.w700),
                                  TextFormField(
                                    controller: courierProvider.courierName,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Contoh: Aksara Melinkung',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: blue))),
                                    validator: (val) => val.isEmpty
                                        ? 'Berikan nama pengguna akun'
                                        : null,
                                  ),
                                  SizedBox(height: 16.0),
                                  CustomText(
                                      text: 'Email Pengguna',
                                      weight: FontWeight.w700),
                                  TextFormField(
                                      controller: courierProvider.email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText:
                                              'Contoh: karolingkung@mail.com',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: blue))),
                                      validator: (val) => val.isEmpty
                                          ? 'Masukkan alamat email dengan benar'
                                          : null),
                                  SizedBox(height: 16.0),
                                  CustomText(
                                      text: 'Nomor HP untuk login',
                                      weight: FontWeight.w700),
                                  SizedBox(height: 5.0),
                                  Row(children: <Widget>[
                                    Container(
                                        width: 70.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                            // print(
                                            //     "on init ${countryCode.dialCode} ${countryCode.name}");
                                          },
                                          searchDecoration: InputDecoration(
                                              isDense: true,
                                              prefixIcon: Icon(Icons.search),
                                              hintText: 'Ketik nama negara',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  borderSide:
                                                      BorderSide(color: blue))),
                                          dialogTextStyle: TextStyle(
                                              color: black, fontSize: 16.0),
                                        )),
                                    SizedBox(width: 10.0),
                                    Flexible(
                                        flex: 2,
                                        child: TextFormField(
                                            controller: courierProvider
                                                .phoNumberLogin,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  11),
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText: 'Contoh: 81234567890',
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: blue))),
                                            onChanged: (String str) {
                                              _phoneNumberChange(str);
                                            },
                                            validator: (value) => (value
                                                    .isEmpty)
                                                ? 'Masukkan Nomor Ponsel-mu'
                                                : (value.length > 11)
                                                    ? 'Batas Maksimal Nomor Ponsel adalah 11'
                                                    : null))
                                  ]),
                                ])))),
                bottomNavigationBar: Container(
                    height: 77.0,
                    color: white,
                    padding: const EdgeInsets.all(16.0),
                    child: FlatButton(
                        color: green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: CustomText(
                                text: 'BUAT AKUN',
                                color: white,
                                weight: FontWeight.w700)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });

                            // bool value = courierProvider.courierByPhone.isNotEmpty;
                            print(phoneNumber);
                            // print(value);

                            if (courierProvider.courierByPhone.isNotEmpty) {
                              setState(() {
                                loading = false;
                              });
                              _registeredBottomSheet(context);
                            } else {
                              courierProvider.verify(
                                  context,
                                  phoneNumber,
                                  courierProvider.courierName.text,
                                  courierProvider.email.text);
                            }
                          }
                        }))));
  }

  void _registeredBottomSheet(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        context: context,
        builder: (BuildContext context) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width / 2.2,
                            alignment: Alignment.center,
                            child: Image.asset("assets/images/verifailed.png")),
                          CustomText(
                              text:
                                  'Eh, sepertinya nomor kamu sudah terdaftar',
                              size: 18.0,
                              weight: FontWeight.w700),
                          SizedBox(height: 5.0),
                          CustomText(
                              text:
                                  'Nomor ini ${phoneNumber.toString()} sudah terdaftar di Lingtra. Langsung segera masuk, yuk!'),
                          SizedBox(height: 20.0),
                          Container(
                            height: 45,
                            child: FlatButton(
                                color: green,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                            10)),
                                child: Center(
                                    child: CustomText(
                                        text: 'MASUK',
                                        color: white,
                                        size: 16.0,
                                        weight:
                                            FontWeight.w700)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                })
                          )
                        ]))
              ]);
        });
  }
}
