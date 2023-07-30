import 'dart:convert';

import 'package:anime_finder/core/AppLocalizations/AppLocalizations.dart';
import 'package:anime_finder/core/ads/bloc/ads_bloc.dart';
import 'package:anime_finder/core/failure/request_state.dart';
import 'package:anime_finder/core/resources/assets_manager.dart';
import 'package:anime_finder/core/resources/size_config.dart';
import 'package:anime_finder/core/themes/dark_theme.dart';
import 'package:anime_finder/core/utils/navigator_manager.dart';
import 'package:anime_finder/features/home/bloc/home_bloc.dart';
import 'package:anime_finder/features/home/view/pages/home_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AnimeItem extends StatelessWidget {
  const AnimeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.getAnimeState) {
          case RequestGetState.defaults:
            return const SliverToBoxAdapter(child: CircularProgressIndicator());
          case RequestGetState.loading:
            return const SliverToBoxAdapter(child: CircularProgressIndicator());

          case RequestGetState.success:
            return state.animeData.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      heightFactor: 15,
                      child: Text(
                        "NoImageSearch".tr(context),
                        style: getTitleMediumTheme(context),
                      ).animate().fade(duration: 2.seconds),
                    ),
                  )
                : SliverGrid.builder(
                    itemCount: state.animeData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (
                      context,
                      i,
                    ) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          fadeNavigation(
                            context: context,
                            page: const HomeDetail(),
                          );
                          context.read<HomeBloc>().add(
                                GetInfoAnimeEvent(
                                  animeId: state.animeData[i].id!,
                                ),
                              );
                          BlocProvider.of<AdsBloc>(context)
                              .add(LoadInterstitialAd());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.memory(
                                    base64Decode(
                                        state.animeData[i].imageGallery!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                state.animeData[i].createdAt ?? "",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ).animate().fade(duration: 3.seconds),
                        ),
                      );
                    },
                  );
          case RequestGetState.error:
            return const SliverToBoxAdapter(child: CircularProgressIndicator());
        }
      },
    );
  }
}
