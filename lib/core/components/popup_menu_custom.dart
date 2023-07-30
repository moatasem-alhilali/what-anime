import 'package:anime_finder/core/bloc/base_bloc.dart';
import 'package:anime_finder/core/themes/dark_theme.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupMenuButtonCustom extends StatelessWidget {
  PopupMenuButtonCustom({super.key});

  List<String> lang = ['العربية', 'English'];

  String? selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        color: Theme.of(context).primaryColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (newVal) {
          // print(newVal);
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            for (int i = 0; i < lang.length; i++)
              PopupMenuItem<String>(
                enabled: true,
                onTap: () {
                  print(lang[i]);
                  if (lang[i] == "العربية") {
                    context
                        .read<BaseBloc>()
                        .add(ChangeLangEvent(isArabic: true));
                  }
                  if (lang[i] == "English") {
                    context
                        .read<BaseBloc>()
                        .add(ChangeLangEvent(isArabic: false));
                  }
                },
                value: selected,
                child: Text(
                  lang[i],
                  style: getTitleMediumTheme(context),
                ),
              ),
          ];
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.language,
            size: 30,
          ),
        ),
      ),
    );
  }
}
