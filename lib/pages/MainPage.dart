import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiger/bloc/changes.dart';
import 'package:tiger/main.dart';
import 'package:tiger/pages/reward_page.dart';
import 'package:tiger/pages/settings_page.dart';
import 'package:tiger/pages/spots_page.dart';
import 'package:tiger/pages/timer.dart';
import 'package:tiger/widgets/icon_widgets_red.dart';
import 'package:tiger/widgets/main_button.dart';
import 'package:tiger/widgets/main_text.dart';
import 'package:tiger/widgets/open_reward_button.dart';
import 'package:tiger/widgets/shared_prefs.dart';

import '../bloc/timer_bloc/timer_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void getFullMoney() async {
    print('object');
    if (await SharedPrefs().getIntFromSharedPreferences('full_balance') !=
        null) {
      Changes.fullBalance =
          (await SharedPrefs().getIntFromSharedPreferences('full_balance'))!;
    }
  }

  @override
  Widget build(BuildContext context) {
    getFullMoney();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/main_image.png'), // Replace with your image asset path
            fit: BoxFit
                .cover, // You can choose different BoxFit values based on your requirements
          ),
        ),
        child: MainScreen(), // Replace with your actual content widget
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  bool canOpen = true;
  Future<void> openVoid() async {
    print('x');
    if (await SharedPrefs().getBoolFromSharedPreferences('open') != null) {
      canOpen = (await SharedPrefs().getBoolFromSharedPreferences('open'))!;
    }
    print('xx' + canOpen.toString());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final timerBloc = BlocProvider.of<TimerBloc>(context);
    openVoid();
    timerBloc.add(TimerWithEvent(opened: canOpen));
    return BlocBuilder(
        bloc: timerBloc,
        builder: (context, state) {
          if (state is TimerWithState) {
            if (canOpen) {
              canOpen = state.opened;
            }
          }

          return Stack(
            children: [
              Positioned(
                  bottom: 0,
                  left: 34,
                  child: Container(
                    child: Image.asset(
                      'assets/images/tiger_main.png',
                      scale: 2,
                    ),
                  )),
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                      )
                    ],
                  )),
              Positioned(
                  bottom: height * 0.1,
                  left: (width - 241) / 2,
                  child: Column(
                    children: [
                      MainButton(
                          buttonText: 'Spots',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpotsPage()));
                          }),
                      MainButton(
                        buttonText: 'Exit',
                        onTap: () => exit(0),
                      )
                    ],
                  )),
              Positioned(
                  top: height * 0.1,
                  left: (width - 180) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: 'TIGER',
                        textSize: 40,
                        strokeWidth: 10,
                      ),
                      MainText(
                        text: 'FORTUNE',
                        textSize: 40,
                        strokeWidth: 10,
                      )
                    ],
                  )),
              Positioned(
                  top: height * 0.14,
                  right: width * 0.04,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: canOpen,
                        child: Image.asset(
                          'assets/images/daily_reward_closed.png',
                          width: width * 0.18,
                          height: width * 0.18,
                        ),
                      ),
                      Visibility(
                        visible: !canOpen,
                        child: Image.asset(
                          'assets/images/reward_open.png',
                          width: width * 0.18,
                          height: width * 0.18,
                        ),
                      ),
                      MainText(
                        text: 'DAILY REWARD',
                        textSize: 20,
                        strokeWidth: 5,
                      ),
                      Visibility(
                        visible: canOpen,
                        child: Container(
                          width: 160,
                          child: Text(
                            'Your daily reward is ready.',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: !canOpen,
                          child: Container(
                            width: 165,
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'You can open daily reward in ',
                                style: TextStyle(fontSize: 18),
                              ),
                              WidgetSpan(child: CountdownTimer())
                            ])),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      OpenRewardButton(
                        openButtonText: 'Open reward',
                        onTap: () {
                          if (canOpen) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RewardPage()));
                          }
                        },
                      )
                    ],
                  )),
            ],
          );
        });
  }
}
