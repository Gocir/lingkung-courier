import 'package:flutter/material.dart';
import 'package:lingkung_courier/models/trashReceiveModel.dart';
import 'package:lingkung_courier/services/trashReceiveService.dart';

class TrashReceiveProvider with ChangeNotifier{
  TrashReceiveServices _trashReceiveService = TrashReceiveServices();
  TrashReceiveModel _trashReceiveModel;
  List<TrashReceiveModel> trashReceives = [];
  List<Map<String, dynamic>> trashReceived = [];
  List<TrashReceiveModel> trashReceiveByPartner = [];

  // Getter
  TrashReceiveModel get trashReceiveModel => _trashReceiveModel;

  TrashReceiveProvider.initialize(){
    loadTrashReceive();
  }

  loadTrashReceive() async {
    trashReceives = await _trashReceiveService.getTrashReceive();
    notifyListeners();
  }

  loadSingleTrashReceive({String trashReceiveId, String partnerId}) async{
    _trashReceiveModel = await _trashReceiveService.getTrashReceiveById(id: trashReceiveId, partnerId: partnerId);
    notifyListeners();
  }

  loadTrashReceiveByPartner(String partnerId)async{
    trashReceiveByPartner = await _trashReceiveService.getTrashReceiveByPartner(partnerId: partnerId);
    notifyListeners();
  }

  loadTrashReceived(String partnerId)async{
    trashReceived = await _trashReceiveService.getTrashReceived(partnerId: partnerId);
    // notifyListeners();
  }
}