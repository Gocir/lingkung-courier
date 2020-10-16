import 'package:flutter/material.dart';
import 'package:lingkung_courier/utilities/colorStyle.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign align;
  final TextOverflow over;
  final int line;
  final Color color;
  final double size;
  final FontStyle style;
  final FontWeight weight;

  //name constructor that has a positional parameters with the text required
  //and the other parameters optional
  CustomText(
      {@required this.text,
      this.align,
      this.over,
      this.line,
      this.color,
      this.size,
      this.style,
      this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      overflow: over,
      maxLines: line,
      style: TextStyle(
          color: color ?? black,
          fontFamily: "Poppins",
          fontSize: size ?? 14,
          fontStyle: style,
          fontWeight: weight),
    );
  }
}
