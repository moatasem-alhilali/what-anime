import 'dart:async';
import 'package:anime_finder/core/failure/request_state.dart';
import 'package:bloc/bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meta/meta.dart';

part 'ads_event.dart';
part 'ads_state.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  AdsBloc() : super(AdsState()) {
    //load Interstitial Ad
    on<LoadInterstitialAd>(loadInterstitialAd);
  }

  //Interstitial Ad
  late InterstitialAd interstitialAd;
  var _adUnitId = 'ca-app-pub-2003910926899647/5259355790';

  FutureOr<void> loadInterstitialAd(event, emit) async {
    emit(AdsState(adsRequestState: AdsRequestState.loading));
    await InterstitialAd.load(
      adUnitId: _adUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd.dispose();
          emit(AdsState(adsRequestState: AdsRequestState.error));
        },
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          emit(AdsState(adsRequestState: AdsRequestState.success));
        },
      ),
    );
  }

  //
}
