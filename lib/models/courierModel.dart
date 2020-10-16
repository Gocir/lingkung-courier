import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_courier/models/addressModel.dart';
import 'package:lingkung_courier/models/bankAccountModel.dart';
import 'package:lingkung_courier/models/documentModel.dart';

class CourierModel{
  static const ID = "uid";
  static const USER_NAME = "courierName";
  static const EMAIL = "email";
  static const PHONE_NUMBER_LOGIN = "phoneNumberLogin";
  static const IMAGE = "image";
  static const ADDRESS = "address";
  static const DOCUMENT_LIST = "document";
  static const BANK_ACCOUNT = "bankAccount";
  static const BALANCE = "balance";
  static const CUSTOMER = "customer";
  static const WEIGHT = "weight";
  static const STATUS = "accountStatus";

  String _id;
  String _courierName;
  String _email;
  String _phoNumberLogin;
  String _image;
  int _balance;
  int _customer;
  int _weight;
  String _accountStatus;

  //  getters
  String get id => _id;
  String get courierName => _courierName;
  String get email => _email;
  String get phoNumberLogin => _phoNumberLogin;
  String get image => _image;
  int get balance => _balance;
  int get customer => _customer;
  int get weight => _weight;
  String get accountStatus => _accountStatus;

  //  public variable
  AddressModel addressModel;
  DocumentModel documentModel;
  BankAccountModel bankAccountModel;

  CourierModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _courierName = snapshot.data[USER_NAME];
    _email = snapshot.data[EMAIL];
    _phoNumberLogin = snapshot.data[PHONE_NUMBER_LOGIN];
    _image = snapshot.data[IMAGE];
    (snapshot.data[ADDRESS] != null)
        ? addressModel = AddressModel.fromMap(snapshot.data[ADDRESS])
        : addressModel = snapshot.data[ADDRESS];
    (snapshot.data[DOCUMENT_LIST] != null)
        ? documentModel = DocumentModel.fromMap(snapshot.data[DOCUMENT_LIST])
        : documentModel = snapshot.data[DOCUMENT_LIST];
    (snapshot.data[BANK_ACCOUNT] != null)
        ? bankAccountModel = BankAccountModel.fromMap(snapshot.data[BANK_ACCOUNT])
        : bankAccountModel = snapshot.data[BANK_ACCOUNT];
    _balance = snapshot.data[BALANCE];
    _customer = snapshot.data[CUSTOMER];
    _weight = snapshot.data[WEIGHT];
    _accountStatus = snapshot.data[STATUS];
  }

}