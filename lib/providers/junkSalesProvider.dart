import 'package:flutter/material.dart';
import 'package:lingkung_courier/models/directionModel.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/models/trashCartModel.dart';
import 'package:lingkung_courier/services/junkSalesService.dart';

class JunkSalesProvider with ChangeNotifier {
  JunkSalesServices _junkSalesService = JunkSalesServices();
  JunkSalesModel _junkSalesModel;
  List<JunkSalesModel> junkSales = [];
  List<JunkSalesModel> userJunkSales = [];
  List<JunkSalesModel> junkSalesComplete = [];
  List<JunkSalesModel> junkSalesOnProgress = [];
  List<TrashCartModel> listTrash = [];

  JunkSalesProvider.initialize() {
    loadJunkSales();
  }

  JunkSalesModel get junkSalesModel => _junkSalesModel;

  Future<bool> addJunkSales(
      {String junkSalesId,
      String userId,
      String partnerId,
      String courierId,
      String startPoint,
      String destination,
      List<TrashCartModel> trashCartModel,
      String locationBenchmarks,
      int profitEstimate,
      int earth,
      int deliveryCosts,
      int profitTotal}) async {
    
    try {
      List<Map> convertedCart = [];

      Map convertDirection = {
        "startPoint": startPoint,
        "destination": destination,
        "locationBenchmarks": locationBenchmarks
      };

      Map<String, dynamic> junkSales = {
        "id": junkSalesId,
        "userId": userId,
        "partnerId": partnerId,
        "courierId": courierId,
        "direction": convertDirection,
        "profitEstimate": profitEstimate,
        "earth": earth,
        "deliveryCosts": deliveryCosts,
        "profitTotal": profitTotal,
        "status": "Start Orders",
        "orderTime": DateTime.now().millisecondsSinceEpoch
      };
      _junkSalesService.createJunkSales(junkSales: junkSales);

      for (TrashCartModel trashCart in trashCartModel) {
        Map<String, dynamic> listTrash = {
          "id": trashCart.id,
          "trashTypeId": trashCart.trashTypeId,
          "partnerId": trashCart.partnerId,
          "junkSalesId": junkSalesId,
          "image": trashCart.image,
          "name": trashCart.name,
          "price": trashCart.price,
          "weight": trashCart.weight
        };
        convertedCart.add(listTrash);
      }
      for (int i=0; i<convertedCart.length; i++){
        _junkSalesService.addlistTrash(junkSalesId: junkSalesId, listTrash: convertedCart[i]);
      }

      print("USER ID IS: ${userId.toString()}");
      print("DIRECTION IS: ${convertDirection.toString()}");
      print("JUNK SALES IS: ${junkSales.toString()}");
      print("LIST TRASH IS: ${convertedCart.toString()}");
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }

  Future<void> updateJunkSales(
      {String status, DirectionModel directionModel, JunkSalesModel junkSalesModel}) async {
    try {

      Map convertDirection = (directionModel.toMap());
      Map<String, dynamic> junkSales = {
        "id": junkSalesModel.id,
        "userId": junkSalesModel.userId,
        "partnerId": junkSalesModel.partnerId,
        "courierId": junkSalesModel.courierId,
        "direction": convertDirection,
        "profitEstimate": junkSalesModel.profitEstimate,
        "earth": junkSalesModel.earth,
        "deliveryCosts": junkSalesModel.deliveryCosts,
        "profitTotal": junkSalesModel.profitTotal,
        "paymentMethod": "Cash",
        "status": "Taken Orders",
        "orderTime": junkSalesModel.orderTime,
        "collectionTime": "",
        "deliveryTime": "",
        "orderCompleteTime": ""
      };

      _junkSalesService.createJunkSales(junkSales: junkSales);

      print("USER ID IS: ${junkSalesModel.userId.toString()}");
      print("CART ITEM IS: ${junkSales.toString()}");
      notifyListeners();
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  Future<void> deleteJunkSales({String junkSalesId}) async {
    try {
      _junkSalesService.deleteJunkSales(junkSalesId: junkSalesId);

      print("JUNK SALES '${junkSalesId.toString()}' WAS DELETED");
      notifyListeners();
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  loadJunkSales() async {
    junkSales = await _junkSalesService.getJunkSales(status: "Start Orders");
    notifyListeners();
  }
  
  loadSingleJunkSales(String junkSalesId) async {
    _junkSalesModel = await _junkSalesService.getJunkSalesById(junkSalesId: junkSalesId);
    notifyListeners();
  }

  loadJunkSalesComplete() async {
    junkSalesComplete = await _junkSalesService.getJunkSalesComplete(status: "Complete Orders");
    notifyListeners();
  }
  
  loadJunkSalesOnProgress() async {
    junkSalesOnProgress = await _junkSalesService.getJunkSalesOnProgress(listStatus: ["Receive Orders", "Take Orders", "Deliver Orders"]);
    notifyListeners();
  }
  
  loadListTrash(String junkSalesId) async {
    listTrash = await _junkSalesService.getListTrashById(junkSalesId: junkSalesId);
    notifyListeners();
  }

}
