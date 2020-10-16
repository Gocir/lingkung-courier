import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/main.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';

class VerificationCode extends StatefulWidget {
  final String phoneNumber;
  VerificationCode({this.phoneNumber});
  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final courierProvider = Provider.of<CourierProvider>(context);
    return loading
        ? Loading()
        : Scaffold(
            key: _scaffoldStateKey,
            backgroundColor: white,
            appBar: AppBar(
                backgroundColor: white,
                elevation: 0.0,
                iconTheme: IconThemeData(color: black),
                actions: [
                  IconButton(
                      icon: Icon(Icons.help_outline, color: black),
                      onPressed: () {})
                ]),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/images/verifikasi.png', scale: 1.25),
                      CustomText(
                          text: 'Kode OTP sudah dikirim!',
                          size: 22.0,
                          weight: FontWeight.w700),
                      SizedBox(height: 10.0),
                      Flexible(
                          child: CustomText(
                              text:
                                  'Masukkan kode OTP yang kami SMS ke nomor HP Anda yang terdaftar ${widget.phoneNumber}.')),
                      SizedBox(height: 10.0),
                      Form(
                          key: _formKey,
                          child: Row(children: <Widget>[
                            getPinField(key: "1", focusNode: focusNode1),
                            SizedBox(width: 5.0),
                            getPinField(key: "2", focusNode: focusNode2),
                            SizedBox(width: 5.0),
                            getPinField(key: "3", focusNode: focusNode3),
                            SizedBox(width: 5.0),
                            getPinField(key: "4", focusNode: focusNode4),
                            SizedBox(width: 5.0),
                            getPinField(key: "5", focusNode: focusNode5),
                            SizedBox(width: 5.0),
                            getPinField(key: "6", focusNode: focusNode6),
                            Spacer(),
                            CustomText(text: '4:20', weight: FontWeight.w600)
                          ]))
                    ])),
            bottomNavigationBar: Container(
                height: 77.0,
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                    color: green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomText(
                        text: 'KONFIRMASI',
                        color: white,
                        weight: FontWeight.w700),
                    onPressed: () {
                      courierProvider.verifyCodeOTP(context, code);
                      code = "";
                    })));
  }

  // This will return pin field - it accepts only single char
  Widget getPinField({String key, FocusNode focusNode}) => Container(
      // height: 50.0,
      width: 35.0,
      child: TextFormField(
          key: Key(key),
          expands: false,
          autofocus: false,
          focusNode: focusNode,
          onChanged: (String value) {
            if (value.length == 1) {
              code += value;
              switch (code.length) {
                case 1:
                  FocusScope.of(context).requestFocus(focusNode2);
                  break;
                case 2:
                  FocusScope.of(context).requestFocus(focusNode3);
                  break;
                case 3:
                  FocusScope.of(context).requestFocus(focusNode4);
                  break;
                case 4:
                  FocusScope.of(context).requestFocus(focusNode5);
                  break;
                case 5:
                  FocusScope.of(context).requestFocus(focusNode6);
                  break;
                default:
                  FocusScope.of(context).requestFocus(FocusNode());
                  break;
              }
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.digitsOnly
          ],
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)));

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
      duration: Duration(seconds: 2),
    );
    _scaffoldStateKey.currentState.showSnackBar(snackBar);
  }

  onVerified() async {
    _showSnackBar(
        "${Provider.of<CourierProvider>(context, listen: false).errorMessage}");
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => MainPage()));
  }

  onError() {
    _showSnackBar(
        "PhoneAuth error ${Provider.of<CourierProvider>(context, listen: false).errorMessage}");
  }
}
