import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiger/bloc/spinning_bloc/spinning_bloc.dart';

import '../bloc/changes.dart';

class SlotGamePage extends StatefulWidget {
  @override
  _SlotGamePageState createState() => _SlotGamePageState();
}

class _SlotGamePageState extends State<SlotGamePage> {
  late List<List<String>> reelImages;
  late List<Timer> spinTimers;
  late bool isSpinning;

  @override
  void initState() {
    super.initState();
    reelImages = List.generate(
      4,
      (columnIndex) => List.generate(
        4,
        (index) => "assets/images/img_${(index + columnIndex) % 4}.png",
      ),
    );

    spinTimers = List.generate(4, (_) => Timer(Duration.zero, () {}));
    isSpinning = false;
  }

  void startSpinning() {
    isSpinning = true;
    for (var i = 0; i < reelImages.length; i++) {
      spinTimers[i] = Timer.periodic(
        Duration(milliseconds: Random().nextInt(50) + 50),
        (timer) {
          setState(() {
            reelImages[i].insert(0, reelImages[i].removeLast());
          });
        },
      );
    }

    // Automatically stop after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      stopSpinning();
    });
  }

  bool spinning = false;
  void stopSpinning() {
    isSpinning = false;
    for (var timer in spinTimers) {
      timer.cancel();
    }

    // Print the image sources of the third row in each column
    for (var i = 0; i < reelImages.length; i++) {
      final thirdRowImage = reelImages[i][2];
      print('Third row in column $i: $thirdRowImage');
    }
    Changes.img1 = reelImages[0][2];

    if (reelImages[0][2] == reelImages[1][2] &&
        reelImages[1][2] == reelImages[2][2] &&
        reelImages[2][2] == reelImages[3][2]) {
      // Win condition: Images in the third row of all columns are the same
      print('Congratulations! You won!');
      Changes.youWin = true;
    } else {
      print('Try again. Good luck!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final spinningBloc = BlocProvider.of<SpinningBloc>(context);
    return BlocBuilder(
      bloc: spinningBloc,
      builder: (context, state) {
        if (state is isSpinningState) {
          spinning = state.isSpinning;
          if (spinning) {
            startSpinning();
            spinning = false;

            spinningBloc.add(isSpinningEvent(
              isSpinning: false,
            ));
          }
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < reelImages.length; i++)
              SlotReel(images: reelImages[i]),
          ],
        );
      },
    );
  }
}

class SlotReel extends StatelessWidget {
  final List<String> images;

  SlotReel({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.55,
      width: width * 0.094,
      margin: EdgeInsets.symmetric(horizontal: 3),
      alignment: Alignment.center,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: images.length * 3,
        itemBuilder: (context, index) {
          final image = images[index % images.length];
          return Image.asset(
            image,
            width: 60.0,
            height: 60.0,
          );
        },
        itemExtent: width * 0.062,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
