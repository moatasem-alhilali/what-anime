part of 'ads_bloc.dart';

@immutable
class AdsState {
  AdsRequestState adsRequestState;
  AdsState({this.adsRequestState = AdsRequestState.defaults});
}
