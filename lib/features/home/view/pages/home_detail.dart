import 'package:anime_finder/core/ads/bloc/ads_bloc.dart';
import 'package:anime_finder/core/failure/request_state.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:anime_finder/features/home/bloc/home_bloc.dart';
import 'package:anime_finder/features/search/view/widgets/recently_search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                switch (state.getInfoAnimeState) {
                  case RequestGetState.defaults:
                    return const CircularProgressIndicator();

                  case RequestGetState.loading:
                    return const CircularProgressIndicator();

                  case RequestGetState.success:
                    return Column(
                      children: [
                        Wrap(
                          children: [
                            for (int index = 0;
                                index < state.infoAnime.length;
                                index++)
                              ItemSearch(
                                imageNetwork: state.infoAnime[index].image,
                                from: state.infoAnime[index].from,
                                to: state.infoAnime[index].to,
                                episode: state.infoAnime[index].episode,
                                filename: state.infoAnime[index].filename!,
                                similarity: state.infoAnime[index].similarity,
                                onPressed: () async {
                                  if (!await launchUrl(Uri.parse(
                                      state.infoAnime[index].video!))) {
                                    throw Exception('Could not launch !');
                                  }
                                },
                                onPressedCopy: () {
                                  //copy
                                  copyToClipboard(
                                    state.infoAnime[index].filename!
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
                              ).animate().fade(duration: 2.seconds)
                          ],
                        ),
                      ],
                    );

                  case RequestGetState.error:
                    return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
