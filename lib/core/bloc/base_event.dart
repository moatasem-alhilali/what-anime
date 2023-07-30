part of 'base_bloc.dart';

@immutable
abstract class BaseEvent {}

class ChangeLangEvent extends BaseEvent {
  final bool isArabic;
  ChangeLangEvent({required this.isArabic});
}
