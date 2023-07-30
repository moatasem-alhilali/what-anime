part of 'home_bloc.dart';

@immutable
class HomeState {
  RequestGetState getAnimeState;
  RequestGetState getInfoAnimeState;
  List<AnimeModel> animeData;
  List<InfoModel> infoAnime;
  HomeState({
    this.getAnimeState = RequestGetState.defaults,
    this.getInfoAnimeState = RequestGetState.defaults,
    this.animeData = const [],
    this.infoAnime = const [],
  });
  HomeState copyWith({
    RequestGetState? getAnimeState,
    RequestGetState? getInfoAnimeState,
    List<AnimeModel>? animeData,
    List<InfoModel>? infoAnime,
  }) {
    return HomeState(
      getAnimeState: getAnimeState ?? this.getAnimeState,
      getInfoAnimeState: getInfoAnimeState ?? this.getInfoAnimeState,
      animeData: animeData ?? this.animeData,
      infoAnime: infoAnime ?? this.infoAnime,
    );
  }
}
