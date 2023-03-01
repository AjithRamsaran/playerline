import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playerline/bloc/player/player_bloc.dart';
import 'package:playerline/networking/player_apis.dart';
import 'package:playerline/respository/playerRepository.dart';
import 'package:playerline/screens/player_home_page.dart';
import 'package:playerline/simpleBlocObserver.dart';

void main() {
  Bloc.observer = SimpleAppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlayerBloc(
              playerRepository: PlayerRepository(playerApi: PlayerApi()))
            ..add(FetchEvent()),
        )
      ],
      child: MaterialApp(
          title: 'PlayerLine',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const PlayerListHomePage()),
    );
  }
}
