class DocumentModel {
  static const SKCK_IMAGE = "skckImage";
  static const KTP_IMAGE = "ktpImage";
  static const SIM_IMAGE = "simImage";
  static const STNK_IMAGE = "stnkImage";

  String _skckImage;
  String _ktpImage;
  String _simImage;
  String _stnkImage;

  //  getters
  String get skckImage => _skckImage;
  String get ktpImage => _ktpImage;
  String get simImage => _simImage;
  String get stnkImage => _stnkImage;

  DocumentModel.fromMap(Map data) {
    _skckImage = data[SKCK_IMAGE];
    _ktpImage = data[KTP_IMAGE];
    _simImage = data[SIM_IMAGE];
    _stnkImage = data[STNK_IMAGE];
  }

  Map toMap() => {
    SKCK_IMAGE : _skckImage,
    KTP_IMAGE : _ktpImage,
    SIM_IMAGE : _simImage,
    STNK_IMAGE : _stnkImage
  };
}
