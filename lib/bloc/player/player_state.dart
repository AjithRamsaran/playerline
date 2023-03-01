part of 'player_bloc.dart';

enum FetchingStatus { initial, loading, success, failure }

@immutable
abstract class PlayerState extends Equatable {}

class PlayerListState extends PlayerState {
  final bool reachedMaxLimit;
  List<Player> playerList;
  final FetchingStatus fetchingStatus;

  PlayerListState({
    required this.fetchingStatus,
    this.reachedMaxLimit = false,
    this.playerList = const <Player>[],
  });

  PlayerListState copyWith(
      {bool? reachedMaxLimit,
      List<Player>? players,
      FetchingStatus? fetchingStatus}) {
    return PlayerListState(
      reachedMaxLimit: reachedMaxLimit ?? this.reachedMaxLimit,
      playerList: players ?? this.playerList,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
    );
  }

  @override
  List<Object?> get props => [reachedMaxLimit, playerList, fetchingStatus];
}
