import 'package:flutter/material.dart';

class OpenRewardButton extends StatelessWidget {
  final String openButtonText;
  final void Function()? onTap;
  const OpenRewardButton({super.key, required this.openButtonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 162,
        height: 56,
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
          child: Text(
            openButtonText,
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
