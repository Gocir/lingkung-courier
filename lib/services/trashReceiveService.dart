import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_courier/models/trashReceiveModel.dart';

class TrashReceiveServices {
  String collection = "businessPartners";
  String subCollection = "trashReceives";
  Firestore _firestore = Firestore.instance;

  Future<List<TrashReceiveModel>> getTrashReceive() async =>
      _firestore.collection(subCollection).getDocuments().then((result) {
        List<TrashReceiveModel> trashReceives = [];
        for (DocumentSnapshot trashReceive in result.documents) {
          trashReceives.add(TrashReceiveModel.fromSnapshot(trashReceive));
        }
        return trashReceives;
      });

  Future<TrashReceiveModel> getTrashReceiveById({String partnerId, String id}) => _firestore
          .collection(collection)
          .document(partnerId)
          .collection(subCollection)
          .document(id)
          .get()
          .then((doc) {
        return TrashReceiveModel.fromSnapshot(doc);
      });

  Future<List<TrashReceiveModel>> getTrashReceiveByPartner({String partnerId}) async =>
      _firestore
          .collection(collection)
          .document(partnerId)
          .collection(subCollection)
          .where("partnerId", isEqualTo: partnerId)
          .getDocuments()
          .then((result) {
        List<TrashReceiveModel> trashReceiveByPartners = [];
        for (DocumentSnapshot trashReceiveByPartner in result.documents) {
          trashReceiveByPartners.add(TrashReceiveModel.fromSnapshot(trashReceiveByPartner));
        }
        return trashReceiveByPartners;
      });
      
  Future<List<Map>> getTrashReceived({String partnerId}) async =>
      _firestore
          .collection(collection)
          .where("partnerId", isEqualTo: partnerId)
          .getDocuments()
          .then((result) {
        List<Map<String, dynamic>> trashReceiveByPartners = [];
        for (DocumentSnapshot trashReceiveByPartner in result.documents) {
          trashReceiveByPartners.add(trashReceiveByPartner.data);
        }
        return trashReceiveByPartners;
      });
}
