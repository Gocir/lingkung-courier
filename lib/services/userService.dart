import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_courier/models/userModel.dart';

class UserServices{
  String collection = "users";
  Firestore _firestore = Firestore.instance;

  Future<List<UserModel>> getUser() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<UserModel> users = [];
        for (DocumentSnapshot user in result.documents) {
          users.add(UserModel.fromSnapshot(user));
        }
        return users;
      });

  Future<UserModel> getUserById({String id}) => _firestore
          .collection(collection)
          .document(id.toString())
          .get()
          .then((doc) {
          if (doc.data == null) {
          return null;
        }
        return UserModel.fromSnapshot(doc);
      });

}