import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_courier/models/partnerModel.dart';

class PartnerServices{

  String collection = "businessPartners";
  Firestore _firestore = Firestore.instance;

  Future<List<PartnerModel>> getPartner() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<PartnerModel> partners = [];
        for (DocumentSnapshot partner in result.documents) {
          partners.add(PartnerModel.fromSnapshot(partner));
        }
        return partners;
      });

  Future<PartnerModel> getPartnerById({String id}) => _firestore
          .collection(collection)
          .document(id.toString())
          .get()
          .then((doc) {
          if (doc.data == null) {
          return null;
        }
        return PartnerModel.fromSnapshot(doc);
      });

}