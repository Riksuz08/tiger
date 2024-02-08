import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiger/bloc/balance_bloc/balance_bloc.dart';
import 'package:tiger/pages/pause_page.dart';
import 'package:tiger/widgets/icon_widgets_red.dart';
import 'package:tiger/widgets/main_button_little.dart';
import 'package:tiger/widgets/main_text.dart';
import 'package:tiger/widgets/open_reward_button.dart';

import '../bloc/changes.dart';
import '../widgets/icon_widget_blue.dart';
import '../widgets/main_button.dart';
import '../widgets/shared_prefs.dart';

class ResultPage extends StatefulWidget {
  final int win;
  final String gameName;
  final String background;
  final String gameImage;
  const ResultPage(
      {super.key,
      required this.win,
      required this.gameName,
      required this.background,
      required this.gameImage});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  int fullMoney = 0;
  int balance = 0;
  int win = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final balanceBloc = BlocProvider.of<BalanceBloc>(context);

    int fullMoney = Changes.fullBalance;
    print(fullMoney);
    balance = fullMoney;
    print(balance);
    balanceBloc.add(SpinEvent(balance, win));
    return BlocBuilder(
        bloc: balanceBloc,
        builder: (context, state) {
          if (state is BalanceSpinState) {
            balance = state.balance;
          }
          if (state is BalanceSpinState) {
            win = state.win;
          }
          return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget
                        .background), // Replace with your image asset path
                    fit: BoxFit
                        .cover, // You can choose different BoxFit values based on your requirements
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: width * 0.2,
                      child: Image.asset(
                        'assets/images/tiger_result.png',
                        scale: 1.8,
                      ),
                    ),
                    Positioned(
                      top: height * 0.05,
                      right: width * 0.05,
                      child: Image.asset(
                        width: width * 0.25,
                        height: height * 0.9,
                        'assets/images/win_without_number.png',
                      ),
                    ),
                    Positioned(
                        bottom: height * 0.1,
                        left: (width - 241) / 2,
                        child: Column(
                          children: [
                            MainText(
                                text: 'YOU WIN', textSize: 35, strokeWidth: 5),
                            Text(
                              widget.win.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 35),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MainButtonLittle(
                                buttonText: 'Play again',
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                            MainButtonLittle(
                              buttonText: 'Main menu',
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            )
                          ],
                        )),
                    Positioned(
                        bottom: height * 0.1,
                        left: width * 0.08,
                        child: Column(
                          children: [
                            if (widget.gameName == 'ROULETTE')
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MainText(
                                      text: 'SPOT',
                                      textSize: 35,
                                      strokeWidth: 5),
                                  MainText(
                                      text: 'ROULETTE',
                                      textSize: 35,
                                      strokeWidth: 5),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            if (widget.gameName != 'ROULETTE')
                              Column(
                                children: [
                                  MainText(
                                      text: widget.gameName,
                                      textSize: 35,
                                      strokeWidth: 5),
                                ],
                              ),
                            Image.asset(
                              widget.gameImage,
                              width: width * 0.23,
                              height: width * 0.23,
                            ),
                          ],
                        )),
                  ],
                )),
          );
        });
  }
}
