import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_courier/models/addressModel.dart';
import 'package:lingkung_courier/models/bankAccountModel.dart';
import 'package:lingkung_courier/models/documentModel.dart';
import 'package:lingkung_courier/models/courierModel.dart';

class CourierServices {
  String collection = "couriers";
  Firestore _firestore = Firestore.instance;

  void createCourier(Map<String, dynamic> values) {
    String id = values["uid"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updateCourier(Map<String, dynamic> values) {
    _firestore
        .collection(collection)
        .document(values['uid'])
        .updateData(values);
  }

  void createAddress({String userId, AddressModel addressModel}) {
    _firestore
        .collection(collection)
        .document(userId)
        .updateData({"address": addressModel.toMap()});
  }

  void addDocument({String userId, DocumentModel documentModel}) {
    _firestore
        .collection(collection)
        .document(userId)
        .updateData({"document": documentModel.toMap()});
  }

  void addBankAccount({String userId, BankAccountModel bankAccountModel}) {
    _firestore
        .collection(collection)
        .document(userId)
        .updateData({"bankAccount": bankAccountModel.toMap()});
  }

  Future<CourierModel> getCourierById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc) {
        if (doc.data == null) {
          return null;
        }
        return CourierModel.fromSnapshot(doc);
      });

  Future<List<CourierModel>> getCourierByPhone({String phoNumberLogin}) async =>
      _firestore
          .collection(collection)
          .where("phoneNumberLogin", isEqualTo: phoNumberLogin)
          .getDocuments()
          .then((result) {
        List<CourierModel> courierByPhones = [];
        for (DocumentSnapshot courierByPhone in result.documents) {
          courierByPhones.add(CourierModel.fromSnapshot(courierByPhone));
        }
        return courierByPhones;
      });

}