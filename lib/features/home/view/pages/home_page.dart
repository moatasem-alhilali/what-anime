import 'dart:io';

import 'package:anime_finder/core/AppLocalizations/AppLocalizations.dart';
import 'package:anime_finder/core/bloc/base_bloc.dart';
import 'package:anime_finder/core/components/popup_menu_custom.dart';
import 'package:anime_finder/core/resources/size_config.dart';
import 'package:anime_finder/core/themes/dark_theme.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:anime_finder/core/utils/navigator_manager.dart';
import 'package:anime_finder/features/home/bloc/home_bloc.dart';
import 'package:anime_finder/core/components/button_upload_image.dart';
import 'package:anime_finder/features/home/view/widgets/anime_item.dart';
import 'package:anime_finder/features/home/view/widgets/cover_image_sliver.dart';
import 'package:anime_finder/features/search/view/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //APPID=ca-app-pub-2003910926899647~4960467730
  //APPUNIT=ca-app-pub-2003910926899647/2241190650

  
  //appunit test=ca-app-pub-3940256099942544/6300978111
  final _controller = ScrollController();
  late BannerAd bannerAd;
  bool isLoaded = false;
  final adUnitIdTest = 'ca-app-pub-2003910926899647/2241190650';

  @override
  void initState() {
    initAsd();
    super.initState();
  }

  initAsd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitIdTest,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print("===============================");

          print(error);
          print("===============================");
          bannerAd.dispose();
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          fadeNavigation(context: context, page:  SearchScreen());
        },
        child: const Icon(
          Icons.image_search,
          size: 35,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: isLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : const SizedBox(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "welcome".tr(context),
                      style: getTitleMediumTheme(context),
                    ),
                    TextSpan(
                      text: " $username",
                      style: getTitleMediumTheme(context),
                    ),
                  ],
                ),
              ),
              actions: [
                PopupMenuButtonCustom(),
              ],
            ),
            const CustomSliverAppBar(),

            ButtonUploadImage(),

            //Recently SearchItem
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return state.animeData.isEmpty
                    ? const SliverToBoxAdapter()
                    : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 25.0,
                            top: 10,
                            bottom: 15,
                            right: 20,
                          ),
                          child: Text(
                            'RecentlySearch'.tr(context),
                            textAlign: TextAlign.start,
                            style: getTitleMediumTheme(context)
                                .copyWith(fontSize: 22),
                          ),
                        ).animate().fade(duration: 2.seconds),
                      );
              },
            ),

            const AnimeItem(),
          ],
        ),
      ),
    );
  }
}
