import 'dart:io';

import 'package:anime_finder/core/AppLocalizations/AppLocalizations.dart';
import 'package:anime_finder/core/ads/bloc/ads_bloc.dart';
import 'package:anime_finder/core/failure/request_state.dart';
import 'package:anime_finder/core/resources/assets_manager.dart';
import 'package:anime_finder/core/resources/size_config.dart';
import 'package:anime_finder/core/themes/dark_theme.dart';
import 'package:anime_finder/core/components/button_upload_image.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:anime_finder/features/home/bloc/home_bloc.dart';
import 'package:anime_finder/features/search/view/widgets/recently_search_item.dart';
import 'package:anime_finder/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              ButtonUploadImage(isSliver: false),
              const ImageSearchScans(),

              //Recently SearchItem
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return state.searchImageData.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                            right: 20.0,
                            left: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: getTitleMediumTheme(context)
                                  .copyWith(fontSize: 20),
                              children: [
                                TextSpan(
                                  text: "result".tr(context),
                                ),
                                TextSpan(
                                  text: " ${state.searchImageData.length}",
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),

              //build item
              BlocConsumer<SearchBloc, SearchState>(
                listener: (context, state) {
                  if (state.uploadState == RequestState.success) {
                    BlocProvider.of<HomeBloc>(context).add(GetAnimeEvent());
                    BlocProvider.of<AdsBloc>(context).add(LoadInterstitialAd());
                  }
                },
                builder: (context, state) {
                  switch (state.uploadState) {
                    case RequestState.defaults:
                      return const SizedBox();
                    case RequestState.loading:
                      return const SizedBox();
                    case RequestState.success:
                      return Column(
                        children: [
                          Wrap(
                            children: [
                              for (int index = 0;
                                  index < state.searchImageData.length;
                                  index++)
                                ItemSearch(
                                  from: state.searchImageData[index].from,
                                  to: state.searchImageData[index].to,
                                  imageNetwork:
                                      state.searchImageData[index].image,
                                  episode: state.searchImageData[index].episode,
                                  filename:
                                      state.searchImageData[index].filename!,
                                  similarity:
                                      state.searchImageData[index].similarity,
                                  onPressed: () async {
                                    counter++;
                                    print(counter);
                                    if (counter == 2) {
                                      BlocProvider.of<AdsBloc>(context)
                                          .interstitialAd
                                          .show();
                                    } else {
                                      try {
                                        await launchUrl(Uri.parse(state
                                            .searchImageData[index].video!));
                                        print(counter);
                                      } catch (e) {
                                        throw Exception('Could not launch !');
                                      }
                                    }
                                  },
                                  onPressedCopy: () {
                                    //copy
                                    copyToClipboard(
                                      state.searchImageData[index].filename!
                                          .split('.mp4')[0],
                                    );

                                    //show ads
                                    try {
                                      BlocProvider.of<AdsBloc>(context)
                                          .interstitialAd
                                          .show();
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                )
                            ],
                          ),
                        ],
                      ).animate().fade(duration: 2.seconds);

                    case RequestState.error:
                      return Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text("error".tr(context)),
                      );
                    case RequestState.pickImage:
                      return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSearchScans extends StatelessWidget {
  const ImageSearchScans({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          print(state.uploadState);
          switch (state.uploadState) {
            case RequestState.defaults:
              return const NoSelectImage();
            case RequestState.loading:
              return _ImageFile(
                image: state.imageString,
              );
            case RequestState.pickImage:
              return _ImageFile(
                image: state.imageString,
              );

            case RequestState.success:
              return _ImageFile(
                image: state.imageString,
                isAnimate: false,
              );

            case RequestState.error:
              return _ImageFile(
                image: state.imageString,
              );
          }
        },
      ),
    );
  }
}

class NoSelectImage extends StatelessWidget {
  const NoSelectImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      height: SizeConfig.vertical! * 40,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            FxLottie.naruto3,
            fit: BoxFit.cover,
            height: SizeConfig.vertical! * 35,
          ),
          Text(
            'youDidntSelectAnyImage'.tr(context),
            style: getTitleMediumTheme(context),
          )
        ],
      ),
    ).animate().fade(duration: 2.seconds);
  }
}

class _ImageFile extends StatelessWidget {
  _ImageFile({
    super.key,
    required this.image,
    this.isAnimate = true,
  });

  final String image;
  bool isAnimate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: SizeConfig.horizontal! * 60,
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(
                File(image),
              ),
            ),
          ),
          child: Lottie.asset(
            FxLottie.imageScan,
            animate: isAnimate,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ).animate().fade(duration: 1.seconds);
  }
}
