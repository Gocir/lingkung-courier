import 'package:flutter/material.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';
import 'package:lingkung_courier/widgets/customText.dart';

class CustomButton extends StatelessWidget {
  final String msg;
  final Function onTap;

  const CustomButton({Key key, this.msg, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: GestureDetector(
        onTap: onTap ?? null,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: grey.withOpacity(0.3),
                offset: Offset(2, 1),
                blurRadius: 2)
          ], color: green, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14),
                child: CustomText(
                  text: msg,
                  color: white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}