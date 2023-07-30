import 'dart:io';

import 'package:anime_finder/core/AppLocalizations/AppLocalizations.dart';
import 'package:anime_finder/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonUploadImage extends StatelessWidget {
  ButtonUploadImage({
    super.key,
    this.isSliver = true,
  });
  bool isSliver;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return isSliver
            ? SliverToBoxAdapter(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onTap: () async {
                      // await SystemChannels.platform
                      //     .invokeMethod('SystemNavigator.pop');
                      context.read<SearchBloc>().add(UploadImageEvent());
                    },
                    leading: IconButton(
                      onPressed: () {
                        context.read<SearchBloc>().add(UploadImageEvent());
                      },
                      icon: const Icon(
                        Icons.cloud_upload_outlined,
                      ),
                    ),
                    title: Text(
                      "uploadImage".tr(context),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        'pickYourAnimeImageFromGallery'.tr(context),
                        style: TextStyle(
                          color: Colors.grey[400]!,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<SearchBloc>().add(UploadImageEvent());
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                  ).animate().fade(duration: 2.seconds),
                ),
              )
            : Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () {
                    context.read<SearchBloc>().add(UploadImageEvent());
                  },
                  leading: IconButton(
                    onPressed: () {
                      context.read<SearchBloc>().add(UploadImageEvent());
                    },
                    icon: const Icon(
                      Icons.cloud_upload_outlined,
                    ),
                  ),
                  title: Text(
                    "uploadImage".tr(context),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      'pickYourAnimeImageFromGallery'.tr(context),
                      style: TextStyle(
                        color: Colors.grey[400]!,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<SearchBloc>().add(UploadImageEvent());
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ).animate().fade(duration: 2.seconds),
              );
      },
    );
  }
}
