import 'dart:io';
import 'dart:ui';

import 'package:anime_finder/core/AppLocalizations/AppLocalizations.dart';
import 'package:anime_finder/core/failure/request_state.dart';
import 'package:anime_finder/core/resources/assets_manager.dart';
import 'package:anime_finder/core/resources/size_config.dart';
import 'package:anime_finder/core/themes/dark_theme.dart';
import 'package:anime_finder/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ImageSearchScans extends StatelessWidget {
  const ImageSearchScans({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
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
    );
  }
}

class NoSelectImage extends StatelessWidget {
  const NoSelectImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
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
      ),
    );
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
    return SliverToBoxAdapter(
      child: Container(
        width: SizeConfig.horizontal! * 60,
        height: SizeConfig.vertical! * 30,
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
          width: SizeConfig.horizontal! * 60,
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
            width: SizeConfig.horizontal! * 60,
          ),
        ),
      ),
    );
  }
}
