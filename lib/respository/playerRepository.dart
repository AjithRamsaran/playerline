import 'dart:async';
import 'dart:io';
import 'dart:math';

import '../model/player_data_response.dart';
import '../networking/player_apis.dart';

abstract class Repository {
  Future<List<Player>> getPlayers(num pageNo);
}

class PlayerRepository extends Repository {
  final PlayerApi playerApi;

  List<Player> players = [];

  PlayerRepository({required this.playerApi});

  @override
  Future<List<Player>> getPlayers(num pageNo) async {
    var response = await playerApi.getPlayerData(pageNo);
    PlayerDataResponse res = PlayerDataResponse.fromJson(response);
    players = res.data?.newslist ?? [];
    return players;
  }
}
