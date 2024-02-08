import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiger/bloc/balance_bloc/balance_bloc.dart';
import 'package:tiger/pages/pause_page.dart';
import 'package:tiger/pages/result_page.dart';
import 'package:tiger/widgets/icon_widgets_red.dart';
import 'package:tiger/widgets/open_reward_button.dart';

import '../bloc/changes.dart';
import '../widgets/icon_widget_blue.dart';
import '../widgets/shared_prefs.dart';

class RoulettePage extends StatefulWidget {
  const RoulettePage({super.key});

  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RouletteScreen extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> rotationTween;
  RouletteScreen({Key? key, required this.animationController})
      : rotationTween = Tween<double>(begin: 0, end: 3600).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0, 1, curve: Curves.decelerate))),
        super(key: key);
  bool youCan = true;
  int fullMoney = 0;
  int balance = 0;
  int win = 0;
  double random = 0;
  String getPrize(double num) {
    if (num > 345 || num < 10) {
      return 'x20';
    } else if (num > 10 && num < (10 + 360 / 14)) {
      return '50';
    } else if (num > (10 + 360 / 14) && num < (10 + 2 * 360 / 14)) {
      return 'x10';
    } else if (num > (10 + 2 * 360 / 14) && num < (10 + 3 * 360 / 14)) {
      return '100';
    } else if (num > (10 + 3 * 360 / 14) && num < (10 + 4 * 360 / 14)) {
      return 'x20';
    } else if (num > (10 + 4 * 360 / 14) && num < (10 + 5 * 360 / 14)) {
      return '0';
    } else if (num > (10 + 5 * 360 / 14) && num < (10 + 6 * 360 / 14)) {
      return 'x10';
    } else if (num > (10 + 6 * 360 / 14) && num < (10 + 7 * 360 / 14)) {
      return '20';
    } else if (num > (10 + 7 * 360 / 14) && num < (10 + 8 * 360 / 14)) {
      return '10000';
    } else if (num > (10 + 8 * 360 / 14) && num < (10 + 9 * 360 / 14)) {
      return '0';
    } else if (num > (10 + 9 * 360 / 14) && num < (10 + 10 * 360 / 14)) {
      return 'x15';
    } else if (num > (10 + 10 * 360 / 14) && num < (10 + 11 * 360 / 14)) {
      return '20';
    } else if (num > (10 + 11 * 360 / 14) && num < ((10 + 12 * 360 / 14))) {
      return 'x15';
    } else if (num > (10 + 12 * 360 / 14) && num < (345)) {
      return '0';
    } else {
      print(num);
      return num.toString();
    }
  }

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
    Future<void> delayUpdateBalances() async {
      await Future.delayed(Duration(seconds: 4), () {
        balanceBloc.add(SpinEvent(balance, win));
      });
    }

    int x = 0;
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
                    image: AssetImage(
                        'assets/images/slot_background.png'), // Replace with your image asset path
                    fit: BoxFit
                        .cover, // You can choose different BoxFit values based on your requirements
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: height * 0.06,
                      right: width * 0.05,
                      child: IconWidgetsBlue(
                        iconString: 'assets/images/burger_menu.png',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PausePage()));
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            )
                          ],
                        )),
                    Positioned(
                      top: height * 0.1,
                      left: width * 0.1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedBuilder(
                              animation: animationController,
                              builder: (builder, child) {
                                return Transform.rotate(
                                  angle:
                                      (rotationTween.value + random) * pi / 180,
                                  child: Image.asset(
                                    'assets/images/roulette_circle.png',
                                    width: width * 0.8,
                                    height: height * 0.8,
                                  ),
                                );
                              }),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.022, top: height * 0.02),
                            child: Image.asset(
                              'assets/images/pin.png',
                              width: width * 0.12,
                              height: height * 0.12,
                            ),
                          )
                        ],
                      ),
                    ),
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
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
                                    print(balance);
                                    print(fullMoney);
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
                            OpenRewardButton(
                              openButtonText: 'SPIN',
                              onTap: () async {
                                if (fullMoney != 0 && youCan) {
                                  youCan = false;
                                  random = Random().nextInt(360).toDouble();
                                  fullMoney -= balance;
                                  x = balance;
                                  balance = fullMoney;

                                  balanceBloc.add(SpinEvent(balance, win));
                                  animationController.reset();
                                  animationController.forward();
                                } else {
                                  win = 0;
                                  print('no money');
                                }
                                Future.delayed(Duration(milliseconds: 4000),
                                    () async {
                                  youCan = true;

                                  if (getPrize(random) == 'x10') {
                                    print('x10');
                                    x *= 10;
                                    win = x;
                                    balance += x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  } else if (getPrize(random) == 'x20') {
                                    print('x20');
                                    x *= 20;
                                    win = x;
                                    balance += x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  } else if (getPrize(random) == 'x15') {
                                    print('x15');
                                    x *= 15;
                                    win = x;
                                    balance += x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  } else if (getPrize(random) == 'x5') {
                                    print('x5');
                                    x *= 5;
                                    win = x;
                                    balance += x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  } else {
                                    print(getPrize(random));
                                    x = int.parse(getPrize(random));
                                    balance += x;
                                    win = x;
                                    fullMoney = balance;
                                    balanceBloc.add(SpinEvent(balance, win));
                                  }
                                  print('Can' + fullMoney.toString());
                                  SharedPrefs().saveIntToSharedPreferences(
                                      'full_balance', fullMoney);
                                  Changes.fullBalance = (await SharedPrefs()
                                      .getIntFromSharedPreferences(
                                          'full_balance'))!;
                                  print("myValur" +
                                      Changes.fullBalance.toString());
                                  print(win);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResultPage(
                                                win: win,
                                                gameName: 'ROULETTE',
                                                background:
                                                    'assets/images/slot_background.png',
                                                gameImage:
                                                    'assets/images/roulette.png',
                                              )));
                                });
                              },
                            )
                          ],
                        )),
                  ],
                )),
          );
        });
  }
}

class RoutelleAnimation extends StatefulWidget {
  const RoutelleAnimation({super.key});

  @override
  State<RoutelleAnimation> createState() => _RoutelleAnimationState();
}

class _RoutelleAnimationState extends State<RoutelleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RouletteScreen(
      animationController: animationController,
    );
  }
}
