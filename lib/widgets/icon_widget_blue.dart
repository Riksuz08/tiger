import 'package:flutter/material.dart';

class IconWidgetsBlue extends StatelessWidget {
  final String iconString;
  final void Function()? onTap;
  const IconWidgetsBlue({super.key, required this.iconString, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 49,
        height: 49,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color.fromRGBO(38, 121, 228, 1),
          border: Border.all(
            color: Color.fromRGBO(24, 64, 134, 1),
            width: 4.0, // Set the border width to 4
          ),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconString,
              width: 21,
              height: 21,
            ),
          ],
        )),
      ),
    );
  }
}
