import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_courier/models/directionModel.dart';

class JunkSalesModel{
  static const ID = "id";
  static const USER_ID = "userId";
  static const PARTNER_ID = "partnerId";
  static const COURIER_ID = "courierId";
  static const DIRECTION = "direction";
  static const LIST_TRASH = "listTrash";
  static const PROFIT_ESTIMATE = "profitEstimate";
  static const EARTH = "earth";
  static const DELIVERY_COSTS = "deliveryCosts";
  static const PROFIT_TOTAL = "profitTotal";
  static const PAYMENT_METHOD = "paymentMethod";
  static const TRASH_IMAGE = "trashImage";
  static const STATUS = "status";
  static const ORDER_TIME = "orderTime";
  static const COLLECTION_TIME = "collectionTime";
  static const DELIVERY_TIME = "deliveryTime";
  static const ORDER_COMPLETE_TIME = "orderCompleteTime";

  String _id;
  String _userId;
  String _partnerId;
  String _courierId;
  int _profitEstimate;
  int _earth;
  int _deliveryCosts;
  int _profitTotal;
  String _paymentMethod;
  String _trashImage;
  String _status;
  int _orderTime;
  int _collectionTime;
  int _deliveryTime;
  int _orderCompleteTime;

//  getters
  String get id => _id;
  String get userId => _userId;
  String get partnerId => _partnerId;
  String get courierId => _courierId;
  int get profitEstimate => _profitEstimate;
  int get earth => _earth;
  int get deliveryCosts => _deliveryCosts;
  int get profitTotal => _profitTotal;
  String get paymentMethod => _paymentMethod;
  String get trashImage => _trashImage;
  String get status => _status;
  int get orderTime => _orderTime;
  int get collectionTime => _collectionTime;
  int get deliveryTime => _deliveryTime;
  int get orderCompleteTime => _orderCompleteTime;

// public variable
  DirectionModel directionModel;

  JunkSalesModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _userId = snapshot.data[USER_ID];
    _partnerId = snapshot.data[PARTNER_ID];
    _courierId = snapshot.data[COURIER_ID];
    (snapshot.data[DIRECTION] != null)
        ? directionModel = DirectionModel.fromMap(snapshot.data[DIRECTION])
        : directionModel = snapshot.data[DIRECTION];
    _profitEstimate = snapshot.data[PROFIT_ESTIMATE];
    _earth = snapshot.data[EARTH];
    _deliveryCosts = snapshot.data[DELIVERY_COSTS];
    _profitTotal = snapshot.data[PROFIT_TOTAL];
    _paymentMethod = snapshot.data[PAYMENT_METHOD];
    _trashImage = snapshot.data[TRASH_IMAGE];
    _status = snapshot.data[STATUS];
    _orderTime = snapshot.data[ORDER_TIME];
    _collectionTime = snapshot.data[COLLECTION_TIME];
    _deliveryTime = snapshot.data[DELIVERY_TIME];
    _orderCompleteTime = snapshot.data[ORDER_COMPLETE_TIME];
  }
}