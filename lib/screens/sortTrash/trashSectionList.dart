import 'package:flutter/material.dart';
import 'package:lingkung_courier/screens/sortTrash/trashSectionDetail.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
// import 'package:lingkung_courier/widgets/categoryTrash.dart';
import 'package:lingkung_courier/widgets/customText.dart';

class TrashSectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: black),
          title: CustomText(
            text: 'Jenis Sampah',
            color: black,
            size: 20,
            weight: FontWeight.w600,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              // Categories(),
              // SizedBox(height: 16.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                  title: CustomText(
                      text: 'Gelas', size: 14.0, weight: FontWeight.w700),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: green,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrashSectionDetail(),
                        ));
                  },
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                  title: Text(
                    'Botol',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.lightGreen,
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) => TraSectionBottle(),
                    // ));
                  },
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                  title: Text(
                    'Kertas',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.lightGreen,
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) => TraSectionBottle(),
                    // ));
                  },
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                  title: Text(
                    'Buah',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.lightGreen,
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) => TraSectionBottle(),
                    // ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
