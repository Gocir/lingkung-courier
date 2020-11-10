import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/models/trashCartModel.dart';

class JunkSalesServices {
  String collection = "junkSales";
  String subCollection = "listTrash";
  Firestore _firestore = Firestore.instance;

  void createJunkSales({Map<String, dynamic> junkSales}) {
    _firestore.collection(collection).document(junkSales['id']).setData(junkSales);
  }

  void updateJunkSales({Map<String, dynamic> data}) {
    _firestore.collection(collection).document(data['id']).updateData(data);
  }

  void deleteJunkSales({String junkSalesId}) {
    _firestore
        .collection(collection)
        .document(junkSalesId)
        .delete();
  }

  void addListTrash(
      {String junkSalesId, Map<String, dynamic> listTrash}) {
    _firestore
        .collection(collection)
        .document(listTrash['junkSalesId'])
        .collection(subCollection)
        .document(listTrash['id'])
        .setData(listTrash);
  }

  void updateListTrash({String junkSalesId, Map<String, dynamic> data}) {
    _firestore
        .collection(collection)
        .document(junkSalesId)
        .collection(subCollection)
        .document(data['id'])
        .updateData(data);
  }
  
  Future<void> deleteListTrash({String junkSalesId, String trashItemId}) async {
    _firestore
        .collection(collection)
        .document(junkSalesId)
        .collection(subCollection)
        .document(trashItemId)
        .delete();
  }

  Future<List<JunkSalesModel>> getJunkSales({String status}) async =>
      _firestore.collection(collection).where("status", isEqualTo: status).getDocuments().then((result) {
        List<JunkSalesModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(JunkSalesModel.fromSnapshot(order));
        }
        return orders;
      });
  
  Future<JunkSalesModel> getJunkSalesById({String junkSalesId}) async =>
      _firestore.collection(collection).document(junkSalesId).get().then((result) {
         if (result.data == null) {
          return null;
        }
        return JunkSalesModel.fromSnapshot(result);
      });

  Future<List<JunkSalesModel>> getJunkSalesComplete({String courierId, String status}) async =>
      _firestore
          .collection(collection)
          .where("courierId", isEqualTo: courierId)
          .where("status", isEqualTo: status)
          .getDocuments()
          .then((result) {
        List<JunkSalesModel> junkSalesComplete = [];
        for (DocumentSnapshot junkSales in result.documents) {
          junkSalesComplete.add(JunkSalesModel.fromSnapshot(junkSales));
        }
        return junkSalesComplete;
      });

  Future<List<JunkSalesModel>> getJunkSalesOnProgress(
          {String courierId, List listStatus}) async =>
      _firestore
          .collection(collection)
          .where("courierId", isEqualTo: courierId)
          .where("status", whereIn: listStatus)
          .getDocuments()
          .then((result) {
        List<JunkSalesModel> orderOnProgress = [];
        for (DocumentSnapshot order in result.documents) {
          orderOnProgress.add(JunkSalesModel.fromSnapshot(order));
        }
        return orderOnProgress;
      });
  
  Future<List<TrashCartModel>> getListTrashById({String junkSalesId}) async =>
      _firestore
          .collection(collection)
          .document(junkSalesId)
          .collection(subCollection)
          .where('junkSalesId', isEqualTo: junkSalesId)
          .getDocuments()
          .then((result) {
        List<TrashCartModel> listTrashById = [];
        for (DocumentSnapshot trashItem in result.documents) {
          listTrashById.add(TrashCartModel.fromSnapshot(trashItem));
        }
        return listTrashById;
      });

  Future<int> getProfit({String junkSalesId}) async => _firestore
          .collection(collection)
          .document(junkSalesId)
          .collection(subCollection)
          .getDocuments()
          .then((result) {
        if (result.documents == null) {
          return 0;
        }
        int _priceSum = 0;
        for (DocumentSnapshot trashCart in result.documents) {
          _priceSum += trashCart.data['price'] * trashCart.data['weight'];
        }
        int total = _priceSum;
        return total;
      });

  Future<int> getTotalWeight({String junkSalesId}) async => _firestore
          .collection(collection)
          .document(junkSalesId)
          .collection(subCollection)
          .getDocuments()
          .then((result) {
        if (result.documents == null) {
          return 0;
        }
        int _priceSum = 0;
        for (DocumentSnapshot trashCart in result.documents) {
          _priceSum += trashCart.data['weight'];
        }
        int total = _priceSum;
        return total;
      });
  
  Future<List<TrashCartModel>> getListTrashByReceive(
          {String junkSalesId, String trashReceiveId}) async =>
      _firestore
          .collection(collection)
          .document(junkSalesId)
          .collection(subCollection)
          .where("trashTypeId", isEqualTo: trashReceiveId)
          .getDocuments()
          .then((result) {
        List<TrashCartModel> listTrashByReceives = [];
        for (DocumentSnapshot listTrashByReceive in result.documents) {
          listTrashByReceives
              .add(TrashCartModel.fromSnapshot(listTrashByReceive));
        }
        return listTrashByReceives;
      });
}
