import 'package:cloud_firestore/cloud_firestore.dart';

class TrashCartModel {
  static const ID = "id";
  static const TRASH_TYPE_ID = "trashTypeId";
  static const IMAGE = "image";
  static const NAME = "name";
  static const PRICE = "price";
  static const WEIGHT = "weight";
  static const PARTNER_ID = "partnerId";
  static const JUNK_SALES_ID = "userId";

  String _id;
  String _trashTypeId;
  String _image;
  String _name;
  int _weight;
  int _price;
  String _partnerId;
  String _junkSalesId;

  //  getters
  String get id => _id;
  String get trashTypeId => _trashTypeId;
  String get image => _image;
  String get name => _name;
  int get weight => _weight;
  int get price => _price;
  String get partnerId => _partnerId;
  String get junkSalesId => _junkSalesId;

  TrashCartModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _trashTypeId = snapshot.data[TRASH_TYPE_ID];
    _image = snapshot.data[IMAGE];
    _name = snapshot.data[NAME];
    _price = snapshot.data[PRICE];
    _weight = snapshot.data[WEIGHT];
    _partnerId = snapshot.data[PARTNER_ID];
    _junkSalesId = snapshot.data[JUNK_SALES_ID];
  }
}
