import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingkung_courier/contents/bankListContent.dart';
import 'package:lingkung_courier/models/bankAccountModel.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';

class AddBankAccount extends StatefulWidget {
  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String accountNumber = '';
  String accountName = '';
  List<DropdownMenuItem<BankAccountModel>> bankAccountDropDown;
  BankAccountModel selectedItem;

  @override
  void initState() {
    super.initState();
    bankAccountDropDown = getBankAccount(bankList);
  }

  List<DropdownMenuItem<BankAccountModel>> getBankAccount(
      List bankAccountList) {
    List<DropdownMenuItem<BankAccountModel>> items = [];
    for (BankAccountModel bankAccount in bankAccountList) {
      items.add(
        DropdownMenuItem(child: Text(bankAccount.bankNameList), value: bankAccount),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
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
                    text: 'Informasi Rekening Bank',
                    size: 18.0,
                    weight: FontWeight.w600,
                  ),
                  titleSpacing: 0,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.help_outline,
                        color: black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                body: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                  text: 'Nama Bank', weight: FontWeight.w700),
                              DropdownButton<BankAccountModel>(
                                  hint: CustomText(
                                      text: 'Pilih Nama Bank',
                                      size: 16.0,
                                      weight: FontWeight.w500),
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16.0,
                                      color: black),
                                  isExpanded: true,
                                  items: bankAccountDropDown,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedItem = value;
                                      print(selectedItem.bankNameList);
                                    });
                                  },
                                  value: selectedItem),
                              SizedBox(height: 16.0),
                              CustomText(
                                  text: 'Nomor rekening',
                                  weight: FontWeight.w700),
                              TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(15),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                      fontFamily: "Poppins", color: black),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      counterStyle: TextStyle(
                                          fontFamily: "Poppins", color: black),
                                      hintText: 'Masukkan nomor rekening',
                                      hintStyle:
                                          TextStyle(fontFamily: "Poppins"),
                                      errorStyle:
                                          TextStyle(fontFamily: "Poppins"),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: blue))),
                                  onChanged: (String str) {
                                    setState(() {
                                      accountNumber = str;
                                    });
                                  },
                                  validator: (value) => (value.isEmpty)
                                      ? 'Masukkan nomor rekening sesuai buku tabungan'
                                      : (value.length > 16)
                                          ? 'Batas Maksimal nomor rekening adalah 15'
                                          : null),
                              SizedBox(height: 16.0),
                              CustomText(
                                  text: 'Nomor pemilik rekening',
                                  weight: FontWeight.w700),
                              TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                      fontFamily: "Poppins", color: black),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      counterStyle: TextStyle(
                                          fontFamily: "Poppins", color: black),
                                      hintText:
                                          'Nama harus sesuai buku tabungan',
                                      hintStyle:
                                          TextStyle(fontFamily: "Poppins"),
                                      errorStyle:
                                          TextStyle(fontFamily: "Poppins"),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: blue))),
                                  onChanged: (String str) {
                                    setState(() {
                                      accountName = str;
                                    });
                                  },
                                  validator: (value) => (value.isEmpty)
                                      ? 'Masukkan nama pemilik sesuai buku tabungan'
                                      : null)
                            ]))),
                bottomNavigationBar: Container(
                    height: 45.0,
                    margin: EdgeInsets.all(16.0),
                    child: FlatButton(
                        color: (selectedItem.bankNameList == "" && accountName == "" ||
                                accountNumber == "")
                            ? grey
                            : green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: CustomText(
                                text: 'SIMPAN',
                                color: white,
                                size: 16.0,
                                weight: FontWeight.w700)),
                        onPressed: () {
                          save();
                        }))));
  }

  void save() async {
    final courierProvider =
        Provider.of<CourierProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      bool value = await courierProvider.addBankAccount(
          bankName: selectedItem.bankNameList,
          accountNumber: int.parse(accountNumber),
          accountName: accountName);
      if (value) {
        print("Bank Account Saved!");
        _scaffoldStateKey.currentState.showSnackBar(SnackBar(
            content: CustomText(
                text: "Saved!", color: white, weight: FontWeight.w600)));
        courierProvider.reloadCourierModel();
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      } else {
        print("Bank Account failed to Save!");
        setState(() {
          loading = false;
        });
      }
      setState(() => loading = false);
    } else {
      setState(() => loading = false);
    }
  }
}
