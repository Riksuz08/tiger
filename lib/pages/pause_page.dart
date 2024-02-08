import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/icon_widgets_red.dart';
import '../widgets/main_button.dart';
import '../widgets/main_text.dart';

class PausePage extends StatefulWidget {
  const PausePage({super.key});

  @override
  State<PausePage> createState() => _PausePageState();
}

class _PausePageState extends State<PausePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF500000),
        child: PauseScreen(), // Replace with your actual content widget
      ),
    );
  }
}

class PauseScreen extends StatefulWidget {
  const PauseScreen({super.key});

  @override
  State<PauseScreen> createState() => _PauseScreenState();
}

class _PauseScreenState extends State<PauseScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
            bottom: height * 0.05,
            left: width * 0.07,
            child: Row(
              children: [
                IconWidgetsRed(
                  iconString: 'assets/images/voice1.png',
                  visible: true,
                ),
                IconWidgetsRed(
                  iconString: 'assets/images/settings_icon.png',
                  visible: false,
                )
              ],
            )),
        Positioned(
            bottom: height * 0.1,
            left: (width - 241) / 2,
            child: Column(
              children: [
                MainButton(
                    buttonText: 'Continue',
                    onTap: () {
                      Navigator.pop(context);
                    }),
                MainButton(
                  buttonText: 'To Main',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                MainButton(
                  buttonText: 'Exit',
                  onTap: () => exit(0),
                )
              ],
            )),
        Positioned(
          top: height * 0.1,
          left: (width - 120) / 2,
          child: MainText(
            text: 'PAUSE',
            textSize: 40,
            strokeWidth: 8,
          ),
        )
      ],
    );
  }
}
