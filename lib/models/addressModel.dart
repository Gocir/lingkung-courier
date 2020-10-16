class AddressModel {
  static const PROVINCE = "province";
  static const CITY = "city";
  static const SUB_DISTRICT = "subDistrict";
  static const POSTAL_CODE = "postalCode";
  static const ADDRESS_DETAIL = "addressDetail";
  static const LATITUDE = "latitude";
  static const LONGITUDE = "longitude";

  String _province;
  String _city;
  String _subDistrict;
  int _postalCode;
  String _addressDetail;
  String _latitude;
  String _longitude;

  //  getters
  String get province => _province;
  String get city => _city;
  String get subDistrict => _subDistrict;
  int get postalCode => _postalCode;
  String get addressDetail => _addressDetail;
  String get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromMap(Map data) {
    _province = data[PROVINCE];
    _city = data[CITY];
    _subDistrict = data[SUB_DISTRICT];
    _postalCode = data[POSTAL_CODE];
    _addressDetail = data[ADDRESS_DETAIL];
    _latitude = data[LATITUDE];
    _longitude = data[LONGITUDE];
  }

  Map toMap() => {
    PROVINCE : _province,
    CITY : _city,
    SUB_DISTRICT : _subDistrict,
    POSTAL_CODE : _postalCode,
    ADDRESS_DETAIL : _addressDetail,
    LATITUDE : _latitude,
    LONGITUDE : _longitude,
  };
}
