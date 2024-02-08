import 'package:flutter/material.dart';

class IconWidgetsRed extends StatelessWidget {
  final bool visible;
  final String iconString;
  final void Function()? onTap;
  const IconWidgetsRed(
      {super.key, required this.visible, required this.iconString, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color.fromRGBO(238, 33, 33, 1),
          border: Border.all(
            color: Color.fromRGBO(190, 23, 23, 1),
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
            Visibility(
                visible: visible,
                child: Image.asset(
                  'assets/images/voice2.png',
                  width: 10,
                  height: 20,
                ))
          ],
        )),
      ),
    );
  }
}
