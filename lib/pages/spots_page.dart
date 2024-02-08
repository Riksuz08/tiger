import 'package:flutter/material.dart';
import 'package:tiger/pages/pokies_pages.dart';
import 'package:tiger/pages/roulette_page.dart';
import 'package:tiger/pages/slot_page.dart';
import 'package:tiger/widgets/icon_widget_blue.dart';
import '../widgets/icon_widgets_red.dart';
import '../widgets/main_text.dart';
import '../widgets/open_reward_button.dart';

class SpotsPage extends StatefulWidget {
  const SpotsPage({Key? key}) : super(key: key);

  @override
  State<SpotsPage> createState() => _SpotsPageState();
}

class _SpotsPageState extends State<SpotsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/slots_background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SlotsScreen(),
      ),
    );
  }
}

class SlotsScreen extends StatefulWidget {
  @override
  _SlotsScreenState createState() => _SlotsScreenState();
}

class _SlotsScreenState extends State<SlotsScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
          top: (height - 49) * 0.5,
          left: width * 0.25,
          child: IconWidgetsRed(
            visible: false,
            iconString: 'assets/images/back_arrow.png',
            onTap: () {
              if (_currentPage > 0) {
                _pageController.animateToPage(
                  _currentPage - 1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                _pageController.animateToPage(
                  2,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
        Positioned(
          top: (height - 49) * 0.5,
          right: width * 0.25,
          child: IconWidgetsRed(
            visible: false,
            iconString: 'assets/images/next_arrow.png',
            onTap: () {
              if (_currentPage < 2) {
                _pageController.animateToPage(
                  _currentPage + 1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                _pageController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
        Positioned(
            top: height * 0.06,
            left: (width - width * 0.3) / 2,
            child: SizedBox(
              width: width * 0.3,
              height: height,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildGame(
                      position: 0,
                      width: width,
                      height: height,
                      gameName: 'SPOT',
                      gameName2: 'ROULETTE',
                      image: 'assets/images/roulette.png',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RoutelleAnimation()));
                      }),
                  _buildGame(
                      position: 1,
                      width: width,
                      height: height,
                      gameName: 'SPOT SLOT',
                      gameName2: '',
                      image: 'assets/images/slot.png',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SlotPage()));
                      }),
                  _buildGame(
                      position: 2,
                      width: width,
                      height: height,
                      gameName: 'SPOT POKIES',
                      gameName2: '',
                      image: 'assets/images/pokies.png',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PokiesPages()));
                      }),
                  // Add more games as needed
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildGame(
      {required int position,
      required double width,
      required double height,
      required String gameName,
      required String gameName2,
      required String image,
      required void Function()? onTap}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainText(
            text: gameName,
            textSize: 25,
            strokeWidth: 10,
          ),
          MainText(
            text: gameName2,
            textSize: 25,
            strokeWidth: 10,
          ),
          Image.asset(
            image,
            width: width * 0.2,
            height: height * 0.5,
          ),
          SizedBox(
            height: 2,
          ),
          OpenRewardButton(
            openButtonText: 'Play',
            onTap: onTap,
          ),
        ],
      )
    ]);
  }
}
