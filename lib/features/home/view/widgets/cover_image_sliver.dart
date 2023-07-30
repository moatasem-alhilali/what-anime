import 'package:anime_finder/core/resources/assets_manager.dart';
import 'package:anime_finder/core/resources/size_config.dart';
import 'package:anime_finder/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SliverAppBar(
          expandedHeight: SizeConfig.vertical! * 25,
          collapsedHeight: 90,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          stretch: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          flexibleSpace: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor,
            ),
            child: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Row(
                children: [
                  Expanded(
                    child: Lottie.asset(
                      FxLottie.naruto3,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Lottie.asset(
                      FxLottie.saskey,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              expandedTitleScale: 1,
              titlePadding: const EdgeInsets.all(24),
            ),
          ),
        );
      },
    );
  }
}
