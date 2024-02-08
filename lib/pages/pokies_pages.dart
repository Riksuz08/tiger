import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiger/bloc/balance_bloc/balance_bloc.dart';
import 'package:tiger/pages/pause_page.dart';
import 'package:tiger/pages/pokies_game_page.dart';
import 'package:tiger/pages/result_page.dart';

import '../bloc/changes.dart';
import '../bloc/pokies_bloc/pokies_bloc.dart';
import '../widgets/icon_widget_blue.dart';
import '../widgets/icon_widgets_red.dart';
import '../widgets/open_reward_button.dart';
import '../widgets/shared_prefs.dart';

class PokiesPages extends StatefulWidget {
  const PokiesPages({super.key});

  @override
  State<PokiesPages> createState() => _PokiesPagesState();
}

class _PokiesPagesState extends State<PokiesPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/pokies_background.png'), // Replace with your image asset path
            fit: BoxFit
                .cover, // You can choose different BoxFit values based on your requirements
          ),
        ),
        child: PokiesScreen(), // Replace with your actual content widget
      ),
    );
  }
}

class PokiesScreen extends StatefulWidget {
  const PokiesScreen({super.key});

  @override
  State<PokiesScreen> createState() => _PokiesScreenState();
}

class _PokiesScreenState extends State<PokiesScreen> {
  int win = 0;
  int fullMoney = 0;
  int balance = 0;
  bool youCan = true;
  int x = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final pokiesBloc = BlocProvider.of<PokiesBloc>(context);
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
          return Stack(
            children: [
              Positioned(
                top: height * 0.06,
                right: width * 0.05,
                child: IconWidgetsBlue(
                  iconString: 'assets/images/burger_menu.png',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PausePage()));
                  },
                ),
              ),
              Positioned(
                  top: height * 0.05,
                  left: width * 0.05,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        width: width * 0.25,
                        height: height * 0.9,
                        'assets/images/win_table.png',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.21),
                        child: Text(
                          win.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      )
                    ],
                  )),
              Positioned(
                  top: height * 0.15,
                  left: width * 0.15,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        width: width * 0.7,
                        height: height * 0.7,
                        'assets/images/pokies_empty.png',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.17, right: 40),
                        child: PokiesGamePage(),
                      )
                    ],
                  )),
              Positioned(
                  top: height * 0.2,
                  right: width * 0.01,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            width: width * 0.3,
                            height: height * 0.3,
                            'assets/images/balance.png',
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.15),
                            child: Text(
                              balance.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconWidgetsRed(
                            visible: false,
                            iconString: 'assets/images/minus.png',
                            onTap: () {
                              if (balance > 99) {
                                balance -= 100;
                                balanceBloc.add(SpinEvent(balance, win));
                              }
                            },
                          ),
                          IconWidgetsRed(
                            visible: false,
                            iconString: 'assets/images/plus.png',
                            onTap: () {
                              if (balance < fullMoney &&
                                  balance + 100 <= fullMoney) {
                                balance += 100;
                                balanceBloc.add(SpinEvent(balance, win));
                              } else {
                                balance = fullMoney;
                                balanceBloc.add(SpinEvent(balance, win));
                              }
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      BlocBuilder(
                        bloc: pokiesBloc,
                        builder: (context, state) {
                          print(state);

                          return OpenRewardButton(
                            openButtonText: 'SPIN',
                            onTap: () async {
                              if (youCan && fullMoney != 0) {
                                youCan = false;
                                if (state is SpinningTrueState) {
                                  if (state.isSpinning == false) {
                                    pokiesBloc.add(SpinningTrueEvent(
                                      isSpinning: true,
                                    ));
                                  }
                                }
                                fullMoney -= balance;
                                x = balance;
                                balance = fullMoney;
                                balanceBloc.add(SpinEvent(balance, win));
                              } else {
                                win = 0;
                              }
                              Future.delayed(Duration(milliseconds: 4000),
                                  () async {
                                youCan = true;
                                print(Changes.img1);
                                print(Changes.youWin);
                                if (Changes.youWin) {
                                  if (Changes.img1 ==
                                      'assets/images/img_0.png') {
                                    x *= 10;
                                    win = x;
                                    balance += x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  } else if (Changes.img1 ==
                                      'assets/images/img_1.png') {
                                    x *= 20;
                                    win = x;
                                    balance += x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  } else if (Changes.img1 ==
                                      'assets/images/img_2.png') {
                                    x *= 15;
                                    win = x;
                                    balance += x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  } else if (Changes.img1 ==
                                      'assets/images/img_3.png') {
                                    x *= 5;
                                    win = x;
                                    balance += x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  }

                                  Changes.img1 = '';
                                  Changes.youWin = false;
                                }
                                print('Can' + fullMoney.toString());
                                SharedPrefs().saveIntToSharedPreferences(
                                    'full_balance', fullMoney);
                                Changes.fullBalance = (await SharedPrefs()
                                    .getIntFromSharedPreferences(
                                        'full_balance'))!;
                                print(
                                    "myValur" + Changes.fullBalance.toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              win: win,
                                              gameName: 'SPOT POKIES',
                                              background:
                                                  'assets/images/pokies_background.png',
                                              gameImage:
                                                  'assets/images/pokies.png',
                                            )));
                              });
                            },
                          );
                        },
                      )
                    ],
                  )),
            ],
          );
        });
  }
}
