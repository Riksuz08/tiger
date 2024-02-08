import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/icon_widget_blue.dart';
import '../widgets/icon_widgets_red.dart';
import '../widgets/main_button.dart';
import '../widgets/main_text.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPAgeState();
}

class _SettingsPAgeState extends State<SettingsPage> {
  bool vibroValue = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF500000),
      body: Stack(
        children: [
          Positioned(
            top: height * 0.06,
            left: width * 0.05,
            child: IconWidgetsBlue(
              iconString: 'assets/images/back_arrow.png',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
              bottom: height * 0.1,
              left: (width - 241) / 3,
              child: Row(
                children: [
                  Column(
                    children: [
                      MainButton(
                          buttonText: 'Share with friends', onTap: () {}),
                      MainButton(
                        buttonText: 'Privacy Policy',
                        onTap: () {},
                      ),
                      MainButton(
                        buttonText: 'Term of use',
                        onTap: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: width * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vibro',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Switch(
                              value: vibroValue,
                              onChanged: (value) {
                                setState(() {
                                  vibroValue = value;
                                });
                              },
                              activeTrackColor: Colors.red,
                              activeColor: Colors.white,
                            )
                          ],
                        ),
                        Text(
                          'App icon',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.red,
                                  width:
                                      4.0, // Adjust the width of the border as needed
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/images/icon_1.png',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/icon_2.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/icon_3.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/icon_4.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/icon_5.png',
                                width: 50,
                                height: 50,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
            top: height * 0.1,
            left: (width - 200) / 2,
            child: MainText(
              text: 'SETTINGS',
              textSize: 40,
              strokeWidth: 8,
            ),
          )
        ],
      ),
    );
  }
}
