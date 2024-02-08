import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiger/bloc/changes.dart';
import 'package:tiger/bloc/timer_bloc/timer_bloc.dart';
import 'package:tiger/pages/timer.dart';
import 'package:tiger/widgets/white_open_reward_button.dart';

import '../widgets/icon_widget_blue.dart';
import '../widgets/main_text.dart';
import '../widgets/open_reward_button.dart';
import '../widgets/shared_prefs.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({Key? key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/reward_background.png',
            ),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: RewardScreen(
          isButtonPressed: isButtonPressed,
          onOpenButtonPressed: () {
            setState(() {
              isButtonPressed = true;
            });
            // Add your logic for opening the reward here
          },
        ),
      ),
    );
  }
}

class RewardScreen extends StatefulWidget {
  final bool isButtonPressed;
  final VoidCallback onOpenButtonPressed;

  const RewardScreen({
    Key? key,
    required this.isButtonPressed,
    required this.onOpenButtonPressed,
  }) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotationAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    rotationAnimation = Tween<double>(begin: 0, end: 360).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  bool open = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final timerBloc = BlocProvider.of<TimerBloc>(context);
    return BlocBuilder(
        bloc: timerBloc,
        builder: (context, state) {
          return Stack(
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
                left: (width - width * 0.7) * 0.3,
                top: (height - height * 0.6) * 0.5,
                child: Image.asset(
                  'assets/images/yellow_blur.png',
                  width: width * 0.6,
                  height: height * 0.6,
                ),
              ),
              Positioned(
                left: (width - width * 0.5) * 0.3,
                top: (height - height * 0.5) * 0.5,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotationAnimation.value * (3.14 / 180),
                      child: Transform.scale(
                        scale: scaleAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: widget.isButtonPressed
                        ? FadeTransition(
                            opacity: Tween<double>(begin: 0, end: 1).animate(
                              CurvedAnimation(
                                parent: controller,
                                curve: Curves.easeInOut,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.13),
                              child: Image.asset(
                                'assets/images/reward_open.png',
                                scale: 3.5,
                              ),
                            ))
                        : Image.asset(
                            'assets/images/daily_reward_closed.png',
                            width: width * 0.5,
                            height: height * 0.5,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.1,
                right: width * 0.05,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(
                      text: 'DAILY',
                      textSize: 40,
                      strokeWidth: 5,
                    ),
                    MainText(
                      text: 'REWARD',
                      textSize: 40,
                      strokeWidth: 5,
                    ),
                    Visibility(
                      visible: !widget.isButtonPressed,
                      child: Container(
                        width: 160,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: 'Every ',
                              ),
                              TextSpan(
                                text: '24 hours',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              TextSpan(
                                text: ' you can get your daily reward.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.isButtonPressed,
                      child: Container(
                        width: 165,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: 'We give you ',
                              ),
                              TextSpan(
                                text: '200 coins',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' for daily login to the application. We are waiting for you.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Visibility(
                        visible: widget.isButtonPressed,
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
                    Visibility(
                        visible: !widget.isButtonPressed,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            OpenRewardButton(
                              openButtonText: 'Open',
                              onTap: () {
                                widget.onOpenButtonPressed();
                                controller.forward();

                                Changes.fullBalance += 10000;
                                if (state is TimerWithState) {
                                  timerBloc.add(TimerWithEvent(opened: false));
                                }
                                SharedPrefs()
                                    .saveBoolToSharedPreferences('open', false);
                                SharedPrefs().saveIntToSharedPreferences(
                                    'full_balance', Changes.fullBalance);
                              },
                            ),
                          ],
                        )),
                    Visibility(
                      visible: widget.isButtonPressed,
                      child: WhiteOpenRewardButton(
                        openButtonText: 'Open',
                        onTap: () {
                          widget.onOpenButtonPressed();
                          setState(() {
                            Changes.canOpen = false;
                          });
                          controller.forward();
                          Changes.fullBalance += 10000;
                          SharedPrefs().saveIntToSharedPreferences(
                              'full_balance', Changes.fullBalance);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
