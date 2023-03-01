import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';
import '../../model/player_data_response.dart';
import '../../respository/playerRepository.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerListState> {
  PlayerBloc({required this.playerRepository})
      : super(PlayerListState(fetchingStatus: FetchingStatus.initial)) {
    pageNo = -1;

    on<FetchEvent>(getPlayers, transformer: throttleDroppable());
  }

  late Repository playerRepository;
  late int pageNo;

  Future<void> getPlayers(
      FetchEvent event, Emitter<PlayerListState> emit) async {
    if (state.reachedMaxLimit || pageNo == 1) return;
    emit(state.copyWith(
        fetchingStatus:
            pageNo == -1 ? FetchingStatus.initial : FetchingStatus.loading));
    pageNo = pageNo + 1;
    try {
      if (state.fetchingStatus == FetchingStatus.initial) {
        return emit(
          state.copyWith(
            fetchingStatus: FetchingStatus.success,
            players: await playerRepository.getPlayers(pageNo),
            reachedMaxLimit: pageNo == maxPageNumber - 1 ? true : false,
          ),
        );
      }
      final players = await playerRepository.getPlayers(pageNo);
      players.isEmpty
          ? emit(state.copyWith(reachedMaxLimit: true))
          : emit(
              state.copyWith(
                fetchingStatus: FetchingStatus.success,
                players: List.of(state.playerList)..addAll(players),
                reachedMaxLimit: pageNo == maxPageNumber - 1 ? true : false,
              ),
            );
    } catch (e) {
      pageNo = pageNo - 1;
      emit(state.copyWith(fetchingStatus: FetchingStatus.failure, players: []));
    }
  }
}
