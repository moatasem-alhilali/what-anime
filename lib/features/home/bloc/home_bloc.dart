import 'dart:async';

import 'package:anime_finder/core/failure/request_state.dart';
import 'package:anime_finder/core/helper/db/sqflite.dart';
import 'package:anime_finder/features/home/model/anime_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<GetAnimeEvent>(getAnime);
    on<GetInfoAnimeEvent>(getInfoAnime);
  }

  FutureOr<void> getAnime(event, emit) async {
    emit(state.copyWith(getAnimeState: RequestGetState.loading));

    try {
      final result = await DBHelper.getAll();
      emit(state.copyWith(
          animeData: result, getAnimeState: RequestGetState.success));
    } catch (e) {
      emit(state.copyWith(getAnimeState: RequestGetState.error));
    }
  }

  FutureOr<void> getInfoAnime(event, emit) async {
    emit(
      state.copyWith(
        getInfoAnimeState: RequestGetState.loading,
        infoAnime: [],
      ),
    );

    try {
      final result = await DBHelper.getInfoForAnime(event.animeId);
      emit(
        state.copyWith(
          infoAnime: result,
          getInfoAnimeState: RequestGetState.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getInfoAnimeState: RequestGetState.error,
          infoAnime: [],
        ),
      );
    }
  }
}
