import 'package:flutter/material.dart';

class BankAccountModel {
  static const BANK_NAME = "bankName";
  static const ACCOUNT_NUMBER = "accountNumber";
  static const ACCOUNT_NAME = "accountName";

  String id;
  String bankNameList;
  String bankCode;
  String _bankName;
  String _accountName;
  int _accountNumber;

  // name constructors
  BankAccountModel({@required this.id, @required this.bankNameList, @required this.bankCode});

  //  getters
  String get bankNameLists => bankNameList;
  String get bankName => _bankName;
  String get accountName => _accountName;
  int get accountNumber => _accountNumber;

  BankAccountModel.fromMap(Map data) {
    _bankName = data[BANK_NAME];
    _accountName = data[ACCOUNT_NAME];
    _accountNumber = data[ACCOUNT_NUMBER];
  }

  Map toMap() => {
    BANK_NAME : _bankName,
    ACCOUNT_NAME : _accountName,
    ACCOUNT_NUMBER : _accountNumber
  };
}
