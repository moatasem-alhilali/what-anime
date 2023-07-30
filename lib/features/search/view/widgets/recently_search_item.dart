import 'package:anime_finder/core/AppLocalizations/AppLocalizations.dart';
import 'package:anime_finder/core/resources/size_config.dart';
import 'package:anime_finder/core/themes/dark_theme.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:anime_finder/features/search/model/search_model.dart';
import 'package:flutter/material.dart';

class ItemSearch extends StatelessWidget {
  ItemSearch({
    this.anilist,
    this.id,
    this.filename,
    this.episode,
    this.from,
    this.to,
    this.similarity,
    this.video,
    this.imageGallery,
    this.imageNetwork,
    this.onPressed,
    this.onPressedCopy,
  });

  int? id;
  int? anilist;
  String? filename;
  num? episode;
  num? from;
  num? to;
  num? similarity;
  String? video;
  String? imageGallery;
  String? imageNetwork;
  void Function()? onPressed;
  void Function()? onPressedCopy;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(10.0),
          width: SizeConfig.horizontal! * 45,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.vertical! * 20,
                width: double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Theme.of(context).splashColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      print("object");
                    },
                    image: NetworkImage(
                      imageNetwork ?? "",
                    ),
                  ),
                ),
                child: IconButton(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.white.withOpacity(0.1),
                  disabledColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.red,
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                filename!.split('.mp4')[0],
                style: getTitleMediumTheme(context).copyWith(fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              Wrap(
                children: [
                  RichText(
                    text: TextSpan(
                      style:
                          getTitleMediumTheme(context).copyWith(fontSize: 13),
                      children: [
                        TextSpan(text: "start".tr(context)),
                        TextSpan(
                          text: ":${from ?? 0}",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      style:
                          getTitleMediumTheme(context).copyWith(fontSize: 13),
                      children: [
                        TextSpan(text: "end".tr(context)),
                        TextSpan(
                          text: ":${to ?? 0}",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.timer_outlined,
                    size: 20,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).splashColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: RichText(
                  text: TextSpan(
                    style: getTitleMediumTheme(context).copyWith(fontSize: 13),
                    children: [
                      TextSpan(text: "similarity".tr(context)),
                      TextSpan(text: "  ${(similarity! * 100).round()}%"),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).splashColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: RichText(
                  text: TextSpan(
                    style: getTitleMediumTheme(context).copyWith(fontSize: 13),
                    children: [
                      TextSpan(text: "episode".tr(context)),
                      TextSpan(
                        text: "  ${episode ?? 0}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: onPressedCopy ??
              () {
                //copy
                copyToClipboard(
                  filename!,
                );
              },
          icon: const Icon(
            Icons.copy_rounded,
            size: 25,
            color: Colors.white,
          ),
          label: Text(
            "copy".tr(context),
            style: getTitleMediumTheme(context),
          ),
        ),
      ],
    );
  }
}
