import 'package:flutter/material.dart';
import 'package:lingkung_courier/models/courierModel.dart';
import 'package:lingkung_courier/models/junkSalesModel.dart';
import 'package:lingkung_courier/models/trashCartModel.dart';
import 'package:lingkung_courier/models/trashReceiveModel.dart';
import 'package:lingkung_courier/services/junkSalesService.dart';
import 'package:uuid/uuid.dart';

class JunkSalesProvider with ChangeNotifier {
  JunkSalesServices _junkSalesService = JunkSalesServices();
  JunkSalesModel _junkSalesModel;
  List<JunkSalesModel> junkSales = [];
  List<JunkSalesModel> userJunkSales = [];
  List<JunkSalesModel> junkSalesComplete = [];
  List<JunkSalesModel> junkSalesOnProgress = [];
  List<TrashCartModel> listTrash = [];
  int _profit = 0;
  int _totalWeight;

  JunkSalesProvider.initialize() {
    loadJunkSales();
  }

  JunkSalesModel get junkSalesModel => _junkSalesModel;
  int get profit => _profit;
  int get totalWeight => _totalWeight;

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
        _junkSalesService.addListTrash(junkSalesId: junkSalesId, listTrash: convertedCart[i]);
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
      {String status, String courierId, String courierName, JunkSalesModel junkSalesModel}) async {
    try {

      Map<String, dynamic> junkSales = {
        "id": junkSalesModel.id,
        "courierId": courierId,
        "courierName": courierName,
        "status": status,
      };

      _junkSalesService.updateJunkSales(data: junkSales);

      print("USER ID IS: ${junkSalesModel.userId.toString()}");
      print("JUNK SALES IS: ${junkSales.toString()}");
      notifyListeners();
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }
  
  Future<void> updateProfit(
      {int profit, int profitTotal, String junkSalesId}) async {
    try {

      Map<String, dynamic> junkSales = {
        "id": junkSalesId,
        "profitEstimate": profit,
        "profitTotal": profitTotal
      };

      _junkSalesService.updateJunkSales(data: junkSales);

      // print("USER ID IS: ${junkSalesModel.userId.toString()}");
      print("JUNK SALES IS: ${junkSales.toString()}");
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

  Future<void> addListTrash(
      {String junkSalesId, TrashReceiveModel item}) async {
    try {
      var uuid = Uuid();
      String trashId = uuid.v4();
      Map<String, dynamic> itemTrash = {
            "id": trashId,
            "trashTypeId": item.id,
            "partnerId": item.partnerId,
            "junkSalesId": junkSalesId,
            "image": item.image,
            "name": item.trashName,
            "price": item.price,
            "weight": 1
          };

      _junkSalesService.addListTrash(listTrash: itemTrash);

      print("JUNK SALES ID: ${junkSales.toString()}");
      notifyListeners();
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  Future<void> updateItemWeight({String junkSalesId, String status, TrashCartModel trashCartModel}) async {
    try {
      
      Map<String, dynamic> trashItem = {
        "id": trashCartModel.id,
        "trashTypeId": trashCartModel.trashTypeId,
        "junkSalesId": junkSalesId,
        "partnerId": trashCartModel.partnerId,
        "image": trashCartModel.image,
        "name": trashCartModel.name,
        "price": trashCartModel.price,
        "weight": (status == "Increment") ? trashCartModel.weight + 1 : trashCartModel.weight -1
      };
      
      _junkSalesService.updateListTrash(junkSalesId: junkSalesId, data: trashItem);

      print("UPDATE WEIGHT IS: ${trashItem.values.firstWhere((v) => trashItem[v] == 'weight').toString()}");
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }

  loadJunkSales() async {
    junkSales = await _junkSalesService.getJunkSales(status: "Start Orders");
    notifyListeners();
  }
  
  loadJunkSalesOrders() async {
    junkSales = await _junkSalesService.getJunkSales(status: "Take Orders");
    notifyListeners();
  }
  
  loadSingleJunkSales(String junkSalesId) async {
    _junkSalesModel = await _junkSalesService.getJunkSalesById(junkSalesId: junkSalesId);
    notifyListeners();
  }

  loadJunkSalesComplete(CourierModel courierModel) async {
    junkSalesComplete = await _junkSalesService.getJunkSalesComplete(courierId: courierModel.id, status: "Complete Orders");
    notifyListeners();
  }
  
  loadJunkSalesOnProgress(String courierId) async {
    junkSalesOnProgress = await _junkSalesService.getJunkSalesOnProgress(courierId: courierId, listStatus: ["Receive Orders", "Take Orders", "Deliver Orders"]);
    notifyListeners();
  }
  
  loadJunkSalesTakeOrders(String courierId) async {
    junkSalesOnProgress = await _junkSalesService.getJunkSalesOnProgress(courierId: courierId, listStatus: ["Take Orders"]);
    notifyListeners();
  }
  
  loadListTrash(String junkSalesId) async {
    listTrash = await _junkSalesService.getListTrashById(junkSalesId: junkSalesId);
    notifyListeners();
  }

  getTotalWeight(String junkSalesId) async {
    _totalWeight = await _junkSalesService.getTotalWeight(junkSalesId: junkSalesId);
  }

  getProfit(String junkSalesId) async{
    _profit = await _junkSalesService.getProfit(junkSalesId: junkSalesId);
    notifyListeners();
  }

}
