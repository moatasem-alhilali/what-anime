part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetAnimeEvent extends HomeEvent {}

class GetInfoAnimeEvent extends HomeEvent {
  final int animeId;
  GetInfoAnimeEvent({
    required this.animeId,
  });
}
