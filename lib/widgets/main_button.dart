import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const MainButton({super.key, required this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 241,
        height: 56,
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
          child: Text(
            buttonText,
            style: TextStyle(
              color: Color.fromRGBO(252, 252, 252, 1),
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
