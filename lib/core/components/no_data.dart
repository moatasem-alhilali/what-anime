import 'package:anime_finder/core/resources/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: SizeConfig.vertical! * 50,
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(
                "assets/lottie/no_data.json",
              ),
            ),
            const Text(
              'Sorry, the keyword you entered cannot be found,please check again or search with another keyword ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 700.ms);
  }
}
