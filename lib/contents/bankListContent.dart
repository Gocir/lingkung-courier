import 'package:lingkung_courier/models/bankAccountModel.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
String bankId = uuid.v4();

final bankList = [
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Mandiri",
    bankCode: "008"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Syariah Mandiri ",
    bankCode: "451"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Rakyat Indonesia & BRI Syariah",
    bankCode: "002"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Ekspor Indonesia",
    bankCode: "003"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Negara Indonesia & BNI Syariah",
    bankCode: "009"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Central Asia",
    bankCode: "014"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Arta Niaga Kencana",
    bankCode: "020"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank CIMB Niaga & CIMB Niaga Syariah",
    bankCode: "022"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Muamalat",
    bankCode: "147"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Lippo",
    bankCode: "026"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Buana Indonesia",
    bankCode: "023"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Danamon",
    bankCode: "011"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Permata",
    bankCode: "013"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "American Express Bank LTD",
    bankCode: "030"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Maybank IndoCorp",
    bankCode: "947"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Panin",
    bankCode: "019"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank UOB Indonesia",
    bankCode: "058"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "OCBC NISP",
    bankCode: "948"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Citibank N. A.",
    bankCode: "031"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Artha Graha Internasional",
    bankCode: "037"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank of Tokyo Mitsubishi UFJ LTD",
    bankCode: "042"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank DBS Indonesia",
    bankCode: "046"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Standard Chartered Bank",
    bankCode: "050"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Capital Indonesia",
    bankCode: "054"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "ANZ Panin Bank",
    bankCode: "061"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank of China Limited",
    bankCode: "069"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Bumi Arta",
    bankCode: "076"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "HSBC Indonesia",
    bankCode: "041"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Rabobank International Indonesia",
    bankCode: "060"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Mayapada",
    bankCode: "097"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BJB",
    bankCode: "110"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank DKI Jakarta",
    bankCode: "111"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD DIY",
    bankCode: "112"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Jateng",
    bankCode: "113"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Jatim",
    bankCode: "114"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Jambi",
    bankCode: "115"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Sumut",
    bankCode: "117"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Nagari",
    bankCode: "118"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Riau Kepri",
    bankCode: "119"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Sumsel",
    bankCode: "120"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Lampung",
    bankCode: "121"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Kalsel",
    bankCode: "122"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Kalbar",
    bankCode: "123"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Kaltim",
    bankCode: "124"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Kalteng",
    bankCode: "125"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Sulsel",
    bankCode: "126"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Sulut",
    bankCode: "127"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD NTB",
    bankCode: "128"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Bali",
    bankCode: "129"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank NTT",
    bankCode: "130"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Maluku",
    bankCode: "131"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Papua",
    bankCode: "132"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Bengkulu",
    bankCode: "133"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BPD Sulteng",
    bankCode: "134"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Sultra",
    bankCode: "135"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Nusantara Parahyangan",
    bankCode: "145"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank of India Indonesia",
    bankCode: "146"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Mestika Dharma",
    bankCode: "151"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Sinarmas",
    bankCode: "153"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Maspion Indonesia",
    bankCode: "157"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Ganesha",
    bankCode: "161"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "ICBC Indonesia",
    bankCode: "164"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "QNB Indonesia",
    bankCode: "167"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Tabungan Negara",
    bankCode: "200"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Woori Saudara",
    bankCode: "068"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Tabungan Pensiunan Nasional",
    bankCode: "213"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BJB Syariah",
    bankCode: "425"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Mega",
    bankCode: "426"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Bukopin",
    bankCode: "441"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Jasa Jakarta",
    bankCode: "472"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "KEB Hana Bank Indonesia",
    bankCode: "484"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank MNC Internasional",
    bankCode: "485"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "BRI Agro Niaga",
    bankCode: "494"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "SBI Indonesia",
    bankCode: "498"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Royal Indonesia",
    bankCode: "501"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Nationalnobu TBK",
    bankCode: "503"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Mega Syariah",
    bankCode: "506"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Ina Perdana",
    bankCode: "513"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Sahabat Sampoerna",
    bankCode: "523"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Kesejahteraan Ekonomi",
    bankCode: "087"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Central Asia Syariah",
    bankCode: "536"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Artos Indonesia",
    bankCode: "542"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Mayora Indonesia",
    bankCode: "553"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Index Selindo",
    bankCode: "555"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Victoria International",
    bankCode: "566"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank Agris",
    bankCode: "945"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Bank China Trust Indonesia",
    bankCode: "949"
  ),
  BankAccountModel(
    id: bankId,
    bankNameList: "Commonwealth Bank",
    bankCode: "950"
  )
];