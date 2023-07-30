import 'package:anime_finder/core/AppLocalizations/AppLocalizations.dart';
import 'package:anime_finder/core/ads/bloc/ads_bloc.dart';
import 'package:anime_finder/core/bloc/base_bloc.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:anime_finder/features/home/bloc/home_bloc.dart';
import 'package:anime_finder/features/home/view/pages/home_page.dart';
import 'package:anime_finder/features/search/bloc/search_bloc.dart';
import 'package:anime_finder/features/splash/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/resources/routes_manager.dart';
import 'core/themes/dark_theme.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()
            ..add(
              GetAnimeEvent(),
            ),
        ),
        BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
        BlocProvider<BaseBloc>(create: (context) => BaseBloc()),
        BlocProvider<AdsBloc>(
          create: (context) => AdsBloc(),
        ),
      ],
      child: BlocBuilder<BaseBloc, BaseState>(
        builder: (context, state) {
          return MaterialApp(
            onGenerateRoute: RouterGenerator.getRoute,
            initialRoute: RoutesManager.main,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            title: isArabic ? "ماهو الأنمي ؟" : 'What anime ?',
            locale: isArabic ? const Locale('ar') : const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            supportedLocales: const [Locale('ar'), Locale('en')],
            themeAnimationCurve: Curves.easeInOutCubicEmphasized,
            themeAnimationDuration: const Duration(seconds: 1),
            debugShowCheckedModeBanner: false,
            home: isSplash ? SplashScreen() : const MyHomePage(),
          );
        },
      ),
    );
  }
}
