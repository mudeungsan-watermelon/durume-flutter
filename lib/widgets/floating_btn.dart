import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';

class FloatingBtn extends StatelessWidget {
  final String tag;
  final IconData? icon;
  final Function? onPressed;
  final dynamic params;
  final String? text;
  final bool deepPurple;
  final bool isFilled;

  const FloatingBtn({
    super.key,
    required this.tag,
    this.icon,
    this.onPressed,
    this.params,
    this.text,
    this.deepPurple = false,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 45,
      // height: 63,
      width: 48,
      height: 48,
      // child: FloatingActionButton(
      child: RawMaterialButton(
        // heroTag: tag,
        onPressed: onPressed != null ?
            () {params != null ? onPressed!(params) : onPressed!();} : null,
        // backgroundColor: Colors.white,
        fillColor: deepPurple ? Colors.deepPurple : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 3,
        child: icon != null ?
        Icon(icon, color: isFilled ? primaryColor : iconBlack, fill: isFilled ? 1 : null, size: 28,) :
        Text(text ?? "", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),),
      ),
    );
  }
}
