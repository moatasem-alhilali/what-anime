import 'package:anime_finder/core/Bloc%20Observer/BlocObserver.dart';
import 'package:anime_finder/core/helper/db/sqflite.dart';
import 'package:anime_finder/core/helper/dio_helper/dio_helper.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:anime_finder/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/helper/cash/cash_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: ['0B563B399490B1CF7B8D6133441B03E0']);

  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  Bloc.observer = MyBlocObserver();
  await DBHelper.initDb();
  await DioHelper.init();
  await CashHelper.init();
  isArabic = CashHelper.getBool(key: 'lan') ?? true;
  isSplash = CashHelper.getBool(key: 'splash') ?? true;
  username = CashHelper.getString(key: 'username') ?? "";

  runApp(const MainView());
}
