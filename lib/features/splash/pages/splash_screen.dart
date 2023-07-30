import 'package:anime_finder/core/AppLocalizations/AppLocalizations.dart';
import 'package:anime_finder/core/components/my_text_form_field.dart';
import 'package:anime_finder/core/helper/cash/cash_helper.dart';
import 'package:anime_finder/core/resources/assets_manager.dart';
import 'package:anime_finder/core/resources/size_config.dart';
import 'package:anime_finder/core/themes/dark_theme.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:anime_finder/core/utils/navigator_manager.dart';
import 'package:anime_finder/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final _key = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: SizeConfig.vertical! * 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: Lottie.asset(
                  FxLottie.kakashi,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "enterYourname".tr(context),
                style: getTitleLargeTheme(context),
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: MyTextFormField(
                    hintText: "moatasem".tr(context),
                    controller: _textEditingController,
                    messageValidate: "messageValidate".tr(context),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize:
                        Size(double.infinity, SizeConfig.vertical! * 8),
                  ),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await CashHelper.setData(
                          key: 'username', value: _textEditingController.text);
                      await CashHelper.setData(key: 'splash', value: false)
                          .then((value) => fadeNavigationWithRemove(
                                context: context,
                                page: const MyHomePage(),
                              ));
                      username = CashHelper.getString(key: 'username') ?? "";
                    }
                  },
                  child: Text(
                    "save".tr(context),
                    style: getTitleMediumTheme(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
