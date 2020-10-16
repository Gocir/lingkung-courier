import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lingkung_courier/providers/courierProvider.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/utilities/loading.dart';
import 'package:lingkung_courier/widgets/customText.dart';
import 'package:provider/provider.dart';

class AddDocument extends StatefulWidget {
  @override
  _AddDocumentState createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  File _skckImage;
  File _ktpImage;
  File _simImage;
  File _stnkImage;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              key: _scaffoldStateKey,
              appBar: AppBar(
                backgroundColor: white,
                elevation: 1.5,
                iconTheme: IconThemeData(color: black),
                title: CustomText(
                  text: 'Dokumen Persyaratan',
                  size: 18.0,
                  weight: FontWeight.w600,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.help_outline,
                      color: black,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Unggah foto SKCK',
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
                                _uploadSKCKModalBottomSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      widgetSKCK(),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Unggah foto KTP',
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
                                _uploadKTPModalBottomSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      widgetKTP(),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Unggah foto SIM',
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
                                _uploadSIMModalBottomSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      widgetSIM(),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Unggah foto STNK',
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
                                _uploadSTNKModalBottomSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      widgetSTNK(),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: 45.0,
                margin: EdgeInsets.all(16.0),
                child: FlatButton(
                  color: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CustomText(
                      text: 'SIMPAN',
                      color: white,
                      size: 16.0,
                      weight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    save();
                  },
                ),
              ),
            ),
          );
  }

  void _uploadSKCKModalBottomSheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Panduan Unggah SKCK',
                    size: 18.0,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.width / 3.5,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: green,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.width / 3.5,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text:
                        'Pastikan Anda unggah foto SKCK asli, bukan hasil scan ataupun fotokopi.',
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text: 'Pastikan SKCK Anda masih valid.',
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text: 'Pastikan SKCK terlihat jelas.',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 45.0,
                    color: white,
                    child: FlatButton(
                      color: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomText(
                          text: 'LANJUT',
                          color: white,
                          size: 16.0,
                          weight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _getImageSKCK(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _uploadKTPModalBottomSheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Panduan Unggah KTP',
                    size: 18.0,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.width / 3.5,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: green,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.width / 3.5,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text:
                        'Pastikan Anda unggah foto KTP asli, bukan hasil scan ataupun fotokopi.',
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text: 'Pastikan KTP Anda masih valid.',
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text: 'Pastikan KTP terlihat jelas.',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 45.0,
                    color: white,
                    child: FlatButton(
                      color: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomText(
                          text: 'LANJUT',
                          color: white,
                          size: 16.0,
                          weight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _getImageKTP(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _uploadSIMModalBottomSheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Panduan Unggah SIM',
                    size: 18.0,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.width / 3.5,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: green,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.width / 3.5,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text:
                        'Pastikan Anda unggah foto SIM asli, bukan hasil scan ataupun fotokopi.',
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text: 'Pastikan SIM Anda masih valid.',
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text: 'Pastikan SIM terlihat jelas.',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 45.0,
                    color: white,
                    child: FlatButton(
                      color: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomText(
                          text: 'LANJUT',
                          color: white,
                          size: 16.0,
                          weight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _getImageSIM(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _uploadSTNKModalBottomSheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                    text: 'Panduan Unggah STNK',
                    size: 18.0,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.width / 3.5,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: green,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.width / 3.5,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: white,
                            ),
                            child: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text:
                        'Pastikan Anda unggah foto STNK asli, bukan hasil scan ataupun fotokopi.',
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text: 'Pastikan STNK Anda masih valid.',
                  ),
                  SizedBox(height: 10.0),
                  CustomText(
                    text: 'Pastikan STNK terlihat jelas.',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 45.0,
                    color: white,
                    child: FlatButton(
                      color: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomText(
                          text: 'LANJUT',
                          color: white,
                          size: 16.0,
                          weight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _getImageSTNK(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget widgetSKCK() {
    final courierProvider =
        Provider.of<CourierProvider>(context, listen: false);
    if (_skckImage != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.file(
            _skckImage,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (courierProvider.courierModel?.documentModel?.skckImage == null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
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
        imageUrl:
            courierProvider.courierModel.documentModel?.skckImage.toString(),
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          height: 150.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
            color: white,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        placeholder: (context, url) => Container(
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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

  Future _getImageSKCK(ImageSource source) async {
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _skckImage = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget widgetKTP() {
    final courierProvider =
        Provider.of<CourierProvider>(context, listen: false);
    if (_ktpImage != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.file(
            _ktpImage,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (courierProvider.courierModel?.documentModel?.ktpImage == null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
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
        imageUrl:
            courierProvider.courierModel.documentModel?.ktpImage.toString(),
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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

  Future _getImageKTP(ImageSource source) async {
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _ktpImage = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget widgetSIM() {
    final courierProvider =
        Provider.of<CourierProvider>(context, listen: false);
    if (_simImage != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.file(
            _simImage,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (courierProvider.courierModel?.documentModel?.simImage == null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
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
        imageUrl:
            courierProvider.courierModel.documentModel?.simImage.toString(),
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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

  Future _getImageSIM(ImageSource source) async {
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _simImage = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget widgetSTNK() {
    final courierProvider =
        Provider.of<CourierProvider>(context, listen: false);
    if (_stnkImage != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.file(
            _stnkImage,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (courierProvider.courierModel?.documentModel?.stnkImage == null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
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
        imageUrl:
            courierProvider.courierModel.documentModel?.stnkImage.toString(),
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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
          width: MediaQuery.of(context).size.width,
          height: 150.0,
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

  Future _getImageSTNK(ImageSource source) async {
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _stnkImage = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void save() async {
    final courierProvider =
        Provider.of<CourierProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      bool value = await courierProvider.addDocument(
        skckImage: _skckImage.toString(),
        ktpImage: _ktpImage.toString(),
        simImage: _simImage.toString(),
        stnkImage: _stnkImage.toString(),
      );
      if (value) {
        print("Document Saved!");
        _scaffoldStateKey.currentState.showSnackBar(
          SnackBar(
            content: CustomText(
              text: "Saved!",
              color: white,
              weight: FontWeight.w600,
            ),
          ),
        );
        courierProvider.reloadCourierModel();
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      } else {
        print("Document failed to Save!");
        setState(() {
          loading = false;
        });
      }
      setState(() => loading = false);
    } else {
      setState(() => loading = false);
    }
  }
}
