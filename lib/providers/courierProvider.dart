import 'dart:async';
import 'package:lingkung_courier/main.dart';
import 'package:lingkung_courier/models/documentModel.dart';
import 'package:lingkung_courier/models/trashReceiveModel.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
//models
import 'package:lingkung_courier/models/addressModel.dart';
import 'package:lingkung_courier/models/bankAccountModel.dart';
import 'package:lingkung_courier/models/courierModel.dart';
//screens
import 'package:lingkung_courier/screens/authenticate/verificationCode.dart';
import 'package:lingkung_courier/screens/profileDetail/dataVerification.dart';
import 'package:lingkung_courier/screens/profileDetail/accountStatus.dart';
//services
import 'package:lingkung_courier/services/courierService.dart';
//utilities
import 'package:lingkung_courier/utilities/navigator.dart';

enum Status {
  Uninitialized,
  Unauthenticated,
  Authenticated,
  Authenticating,
  Registering,
  Verify,
}
//  Unitialized: Memeriksa apakah pengguna masuk atau tidak. Dalam keadaan ini, kami akan menampilkan Loading.
//  Unauthenticated: Dalam Status ini, kami akan menampilkan halaman authenticate untuk memasukkan kredensial.
//  Authenticating: Pengguna telah menekan tombol masuk dan kami mengautentikasi pengguna. Dalam Status ini, kami akan menampilkan bilah Kemajuan.
//  Authenticated: Pengguna diautentikasi. Dalam Status ini, kami akan menampilkan beranda.

class CourierProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _courier;
  Status _status = Status.Uninitialized;
  CourierServices _courierService = CourierServices();
  CourierModel _courierModel;

  // getter
  FirebaseUser get courier => _courier;
  CourierModel get courierModel => _courierModel;
  Status get status => _status;

  // public variables
  List<TrashReceiveModel> trashReceives = [];
  List<CourierModel> courierByPhone = [];

  final scaffoldStatekey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController courierName = TextEditingController();
  TextEditingController phoNumberLogin = TextEditingController();

  String smsCode;
  String verificationId;
  String errorMessage;
  String name;
  String mail;
  bool loading = false;

  CourierProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  //  Code Sent
  Future<void> verify(BuildContext context, String phoneNumber,
      String courierName, String email) async {
    name = courierName;
    mail = email;
    final PhoneCodeSent codeSent = (String verifId, [int forceCodeResend]) {
      this.verificationId = verifId;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => VerificationCode(phoneNumber: phoneNumber)));
    };

    final PhoneVerificationCompleted verified =
        (AuthCredential authCredential) {
      print(authCredential.toString() + "lets make this work");
    };

    final PhoneVerificationFailed verifailed = (AuthException authException) {
      print(authException.message.toString());
      errorMessage = authException.message;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber.trim(), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verifId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verifId;
          },
          codeSent:
              codeSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 60),
          verificationCompleted: verified,
          verificationFailed: verifailed);
      clearController();
    } catch (e) {
      print(e.toString());
      errorMessage = e.message.toString();
      clearController();
    }
  }

  //  Register
  void _register(
      {String id, String courierName, String email, String phoneNumber}) {
    _courierService.createCourier({
      'uid': id,
      'courierName': courierName,
      'email': email,
      'phoneNumberLogin': phoneNumber,
      'balance': 0,
      'customer': 0,
      'weight': 0,
      'accountStatus': 'Not Verified'
    });
  }

  //  VerifyCode
  void verifyCodeOTP(BuildContext context, String smsCode) async {
    final AuthCredential _authCredential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    _auth.signInWithCredential(_authCredential).then((AuthResult result) async {
      print('Authentication successful');
      if (result.user.uid == courier.uid) {
        _courierModel = await _courierService.getCourierById(courier.uid);
        if (_courierModel == null) {
          _register(
              id: result.user.uid,
              courierName: name,
              email: mail,
              phoneNumber: result.user.phoneNumber);
          print('register');
        }
      }
      if (_courierModel?.addressModel == null ||
          _courierModel?.bankAccountModel == null ||
          _courierModel?.documentModel == null ||
          _courierModel?.image == null ||
          _courierModel?.accountStatus == 'Not Verified') {
        _status = Status.Registering;
        changeScreenReplacement(context, DataVerification());
      } else if (_courierModel?.accountStatus == 'Verify' ||
          _courierModel?.accountStatus == 'Verification Failed' ||
          _courierModel?.accountStatus == 'Verified') {
        _status = Status.Verify;
        changeScreenReplacement(context, AccountStatus());
      } else {
        _status = Status.Authenticated;
        changeScreenReplacement(context, MainPage());
      }
    }).catchError((e) {
      _status = Status.Unauthenticated;
      print(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $e');
    });
  }

  void clearController() {
    courierName.text = "";
    phoNumberLogin.text = "";
    email.text = "";
  }

  Future<void> reloadCourierModel() async {
    _courierModel = await _courierService.getCourierById(courier.uid);
    notifyListeners();
  }

  Future<void> loadUserByPhone(String phoneNumber) async {
    courierByPhone =
        await _courierService.getCourierByPhone(phoNumberLogin: phoneNumber);
    // notifyListeners();
  }
  
  Future<void> loadUserById(String courierId) async {
    _courierModel = await _courierService.getCourierById(courierId);
    notifyListeners();
  }
  

  // Logout
  Future logout() async {
    try {
      _status = Status.Unauthenticated;
      notifyListeners();
      await _auth.signOut();
      print('Courier wes logout');
      return true;
    } catch (e) {
      _status = Status.Authenticating;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<void> _onStateChanged(FirebaseUser firebaseCourier) async {
    if (firebaseCourier == null) {
      _status = Status.Unauthenticated;
    } else {
      _courier = firebaseCourier;
      _courierModel = await _courierService.getCourierById(_courier.uid);
      if (_courierModel?.addressModel == null ||
          _courierModel?.documentModel == null ||
          _courierModel?.bankAccountModel == null ||
          _courierModel?.image == null ||
          _courierModel?.accountStatus == 'Not Verified') {
        _status = Status.Registering;
      } else if (_courierModel?.accountStatus == 'Verify' ||
          _courierModel?.accountStatus == 'Verification Failed' ||
          _courierModel?.accountStatus == 'Verified') {
        _status = Status.Verify;
      } else {
        _status = Status.Authenticated;
      }
    }
    notifyListeners();
  }

  //  Address
  Future<bool> createAddress(
      {String province,
      String city,
      String subDistrict,
      int postalCode,
      String addressDetail,
      String latMaps,
      String longMaps}) async {
    // print("Location On Maps: ${latMaps.toString()}, ${longMaps.toString()}");

    try {
      Map addressItem = {
        "province": province,
        "city": city,
        "subDistrict": subDistrict,
        "postalCode": postalCode,
        "addressDetail": addressDetail,
        "latitude": latMaps,
        "longitude": longMaps
      };

      AddressModel address = AddressModel.fromMap(addressItem);
      print("ADDRESS ARE: ${address.toString()}");
      _courierService.createAddress(
          userId: _courier.uid, addressModel: address);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }

  //  Document
  Future<bool> addDocument({
    String skckImage,
    String ktpImage,
    String simImage,
    String stnkImage,
  }) async {
    try {
      Map documentItem = {
        "skckImage": skckImage,
        "ktpImage": ktpImage,
        "simImage": simImage,
        "stnkImage": stnkImage,
      };

      DocumentModel document = DocumentModel.fromMap(documentItem);
      print("USER IS: ${_courier.uid.toString()}");
      print("DOCUMENT ARE: ${document.toString()}");
      _courierService.addDocument(
          userId: _courier.uid, documentModel: document);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }

  // BankAccount
  Future<bool> addBankAccount(
      {String bankName, int accountNumber, String accountName}) async {
    print("Bank Name: ${bankName.toString()}");

    try {
      Map bankAccountModel = {
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountName": accountName
      };

      BankAccountModel bankAccount = BankAccountModel.fromMap(bankAccountModel);
      print("BANK ACCOUNT IS: ${bankAccount.toString()}");
      _courierService.addBankAccount(
          userId: _courier.uid, bankAccountModel: bankAccount);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }
}
