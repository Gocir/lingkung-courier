import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/services/courierService.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';

class AddProfile extends StatefulWidget {
  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final FirebaseStorage storage = FirebaseStorage.instance;
  CourierServices _courierService = CourierServices();

  String imageUrl;
  File _profileImage;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final courierProvider = Provider.of<CourierProvider>(context);
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              resizeToAvoidBottomPadding: false,
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                elevation: 1.5,
                iconTheme: IconThemeData(color: black),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    courierProvider.reloadCourierModel();
                  },
                ),
                titleSpacing: 0,
                title: CustomText(
                  text: 'Profil Pengemudi',
                  size: 18.0,
                  weight: FontWeight.w600,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.help_outline, color: black),
                    onPressed: () {},
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: 'Banner Usaha',
                          weight: FontWeight.w700,
                        ),
                        Container(
                          height: 30.0,
                          child: OutlineButton(
                            color: white,
                            highlightColor: white,
                            highlightedBorderColor: green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: green,
                              width: 1.5,
                            ),
                            child: CustomText(
                              text: 'UNGGAH',
                              color: green,
                              size: 12.0,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              _getImage(ImageSource.camera);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    widgetBanner(),
                    SizedBox(height: 10.0),
                    CustomText(
                      text:
                          'Ketentuan unggah: Harus foto formal terbaru. Jika foto yang di unggah tidak sesuai, tim Lingkung berhak menggantinya.',
                      size: 12.0,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget widgetBanner() {
    final courierProvider = Provider.of<CourierProvider>(context, listen: false);
    if (courierProvider.courierModel?.image == null) {
      return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/noimage.png"),
            fit: BoxFit.contain,
          ),
          color: white,
          border: Border.all(
            color: Colors.grey[200],
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: courierProvider.courierModel?.image.toString(),
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            color: white,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        placeholder: (context, url) => Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: Colors.grey[200],
              width: 1.0,
            ),
          ),
          child: SpinKitThreeBounce(
            color: black,
            size: 20.0,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/noimage.png"),
              fit: BoxFit.contain,
            ),
            color: white,
            border: Border.all(
              color: Colors.grey[200],
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );
    }
  }

  Future _getImage(ImageSource source) async {
    final courierProvider = Provider.of<CourierProvider>(context, listen: false);
    setState(() => loading = true);

    final pickedImage = await ImagePicker().getImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
      if (_profileImage != null) {
        final String picture =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task =
            storage.ref().child(picture).putFile(_profileImage);
        StorageTaskSnapshot taskSnapshot =
            await task.onComplete.then((snapshot) => snapshot);
        task.onComplete.then((snapshot) async {
          imageUrl = await taskSnapshot.ref.getDownloadURL();
          _courierService.updateCourier({
            "uid": courierProvider.courier.uid,
            "image": imageUrl,
          });
        });
        setState(() => loading = false);
        courierProvider.reloadCourierModel();
      }
      setState(() => loading = false);
      courierProvider.reloadCourierModel();
    } else {
      setState(() => loading = false);
      print('No image selected.');
    }

    // if (_profileImage != null) {
    //   final String picture =
    //       "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    //   StorageUploadTask task =
    //       storage.ref().child(picture).putFile(_profileImage);
    //   StorageTaskSnapshot taskSnapshot =
    //       await task.onComplete.then((snapshot) => snapshot);
    //   task.onComplete.then((snapshot) async {
    //     imageUrl = await taskSnapshot.ref.getDownloadURL();
    //     _courierService.updateCourier({
    //       "uid": courierProvider.courier.uid,
    //       "image": imageUrl,
    //     });
    //   });
    //   courierProvider.reloadCourierModel();
    //   setState(() => loading = false);
    // } else {
    //   setState(() => loading = false);
    // }
  }

  // void _getImage() async {
  //   final courierProvider =
  //       Provider.of<CourierProvider>(context, listen: false);
  //   setState(() => loading = true);
  //   File image = await ImagePickerGC.pickImage(
  //       context: context,
  //       source: ImgSource.Both,
  //       cameraIcon: Icon(Icons.camera_alt, color: black),
  //       cameraText:
  //           CustomText(text: 'Kamera', size: 18.0, weight: FontWeight.w600,),
  //       galleryIcon: Icon(Icons.photo_library, color: black),
  //       galleryText:
  //           CustomText(text: 'Galeri', size: 18.0, weight: FontWeight.w600,),
  //       barrierDismissible: true);
  //   // if (image != null) {
  //   //   File cropped = await ImageCropper.cropImage(
  //   //       sourcePath: image.path,
  //   //       aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3),
  //   //       compressQuality: 100,
  //   //       maxWidth: 400,
  //   //       maxHeight: 600,
  //   //       compressFormat: ImageCompressFormat.jpg,
  //   //       androidUiSettings: AndroidUiSettings(
  //   //           toolbarColor: blue,
  //   //           toolbarWidgetColor: white,
  //   //           toolbarTitle: "Atur Foto",
  //   //           statusBarColor: blue,
  //   //           backgroundColor: white,
  //   //           activeControlsWidgetColor: green,),);

  //   //   setState(() => _profileImage = cropped);
  //   // } else {
  //   //   setState(() => loading = false);
  //   // }

  //   if (image != null) {
  //     final String picture =
  //         "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
  //     StorageUploadTask task =
  //         storage.ref().child(picture).putFile(image);
  //     StorageTaskSnapshot taskSnapshot =
  //         await task.onComplete.then((snapshot) => snapshot);
  //     task.onComplete.then((snapshot) async {
  //       imageUrl = await taskSnapshot.ref.getDownloadURL();
  //       _courierService.updateCourier({
  //         "uid": courierProvider.courier.uid,
  //         "image": imageUrl,
  //       });
  //     });
  //     setState(() => loading = false);
  //     courierProvider.reloadCourierModel();
  //   } else {
  //     setState(() => loading = false);
  //   }
  // }
}
