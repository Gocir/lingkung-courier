// import 'package:flutter/material.dart';
// import 'package:lingkung_courier/providers/addressProvider.dart';
// import 'package:lingkung_courier/utilities/colorStyle.dart';
// import 'package:lingkung_courier/widgets/customText.dart';
// import 'package:lingkung_courier/widgets/map.dart';
// import 'package:provider/provider.dart';

// const kGoogleApiKey = "AIzaSyBxcEIaTorP_Qj34K0EH32zZ5Bmd-i7SRc";

// class SetLocation extends StatefulWidget {
//   @override
//   _SetLocationState createState() => _SetLocationState();
// }

// class _SetLocationState extends State<SetLocation> {
//   final scaffoldStateKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     final addressProvider = Provider.of<AddressProvider>(context);
//     return Scaffold(
//         key: scaffoldStateKey,
//         appBar: AppBar(
//             backgroundColor: white,
//             automaticallyImplyLeading: false,
//             title: CustomText(
//                 text: 'Set Lokasi Mitra Pengelola',
//                 size: 18.0,
//                 weight: FontWeight.w600,),
//             ),
//         body: Maps(),
//         bottomNavigationBar: 
//         Container(
//             height: 200.0,
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Row(children: <Widget>[
//                     Icon(Icons.my_location, size: 30.0, color: Colors.red),
//                     SizedBox(width: 16.0),
//                     (addressProvider.titleCurrentAddress == null && addressProvider.currentAddress == null) ?
//                     Flexible(child: CustomText(text: 'Loading ...', weight: FontWeight.w600)) :
//                     Flexible(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           CustomText(
//                               text: '${addressProvider.titleCurrentAddress}',
//                               over: TextOverflow.fade,
//                               size: 16.0,
//                               weight: FontWeight.w700),
//                           CustomText(
//                             text: '${addressProvider.currentAddress}',
//                             line: 4,
//                             over: TextOverflow.ellipsis,
//                             align: TextAlign.justify,
//                             color: black.withOpacity(0.8),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),
//                   Container(
//                       height: 45.0,
//                       child: FlatButton(
//                           color: green,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Center(
//                               child: CustomText(
//                                   text: 'KONFIRMASI',
//                                   color: white,
//                                   size: 16.0,
//                                   weight: FontWeight.w700)),
//                           onPressed: () {
//                             Navigator.pop(context, addressProvider.initialPosition);
//                           }))
//                 ]))
//         );
//   }
// }
