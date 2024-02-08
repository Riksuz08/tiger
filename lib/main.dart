import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:tiger/bloc/pokies_bloc/pokies_bloc.dart';
import 'package:tiger/bloc/spinning_bloc/spinning_bloc.dart';
import 'package:tiger/bloc/timer_bloc/timer_bloc.dart';
import 'package:tiger/pages/MainPage.dart';

import 'bloc/balance_bloc/balance_bloc.dart'; // Import your BalanceBloc

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((value) => runApp(
            DevicePreview(
              enabled: !kReleaseMode,
              builder: (context) => MyApp(), // Wrap your app
            ),
          ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BalanceBloc>(
          create: (context) => BalanceBloc(),
        ),
        BlocProvider<SpinningBloc>(
          create: (context) => SpinningBloc(),
        ),
        BlocProvider<PokiesBloc>(create: (context) => PokiesBloc()),
        BlocProvider<TimerBloc>(create: (context) => TimerBloc()),
        // Add other BlocProviders if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
