import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const IMAGE = "image";
  static const PHONE_NUMBER = "phoneNumber";
  static const BALANCE = "balance";
  static const POINT = "point";
  static const WEIGHT = "weight";
  static const CART_PRODUCT = "cartProduct";

  String _id;
  String _name;
  String _email;
  String _image;
  String _phoNumber;
  int _balance;
  int _point;
  int _weight;

  //  getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get image => _image;
  String get phoNumber => _phoNumber;
  int get balance => _balance;
  int get point => _point;
  int get weight => _weight;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _image = snapshot.data[IMAGE];
    _phoNumber = snapshot.data[PHONE_NUMBER];
    _balance = snapshot.data[BALANCE];
    _point = snapshot.data[POINT];
    _weight = snapshot.data[WEIGHT];
  }
}
