import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_courier/models/addressModel.dart';

class PartnerModel{
  static const ID = "uid";
  static const EMAIL = "email";
  static const PHONE_NUMBER_LOGIN = "phoneNumberLogin";
  static const USER_NAME = "userName";
  static const PARTNER_BUSINESS_NAME = "businessName";
  static const ADDRESS = "address";
  static const IMAGE = "image";
  static const BALANCE = "balance";
  static const CUSTOMER = "customer";
  static const WEIGHT = "weight";
  static const ACCOUNT_STATUS = "accountStatus";

  String _id;
  String _email;
  String _phoNumberLogin;
  String _userName;
  String _businessName;
  String _image;
  int _balance;
  int _customer;
  int _weight;
  String _accountStatus;

//  getters
  String get id => _id;
  String get email => _email;
  String get phoNumberLogin => _phoNumberLogin;
  String get userName => _userName;
  String get businessName => _businessName;
  String get image => _image;
  int get balance => _balance;
  int get customer => _customer;
  int get weight => _weight;
  String get accountStatus => _accountStatus;

//  public variable
  AddressModel addressModel;

  PartnerModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _email = snapshot.data[EMAIL];
    _phoNumberLogin = snapshot.data[PHONE_NUMBER_LOGIN];
    _userName = snapshot.data[USER_NAME];
    _businessName = snapshot.data[PARTNER_BUSINESS_NAME];
    (snapshot.data[ADDRESS] != null)
        ? addressModel = AddressModel.fromMap(snapshot.data[ADDRESS])
        : addressModel = snapshot.data[ADDRESS];
    _image = snapshot.data[IMAGE];
    _balance = snapshot.data[BALANCE];
    _customer = snapshot.data[CUSTOMER];
    _weight = snapshot.data[WEIGHT];
    _accountStatus = snapshot.data[ACCOUNT_STATUS];
  }

}