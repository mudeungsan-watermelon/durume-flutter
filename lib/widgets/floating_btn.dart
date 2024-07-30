import 'package:flutter/material.dart';

class FloatingBtn extends StatelessWidget {
  final String tag;
  final IconData icon;
  final Function? onPressed;
  final dynamic params;
  final String? text;

  const FloatingBtn({
    super.key,
    required this.tag,
    required this.icon,
    this.onPressed,
    this.params,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 63,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: FloatingActionButton(
          heroTag: tag,
          onPressed: onPressed != null ?
              () {params != null ? onPressed!(params) : onPressed!();} : null,
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
          ),
          // child: Text(text),
          child: Icon(icon),
        ),
      ),
    );
  }
}
