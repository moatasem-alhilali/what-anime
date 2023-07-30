import 'package:anime_finder/core/components/shimmer_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseShimmer(
        child: Text(
          "no Internet".toUpperCase(),
          style: TextStyle(
            fontSize: 40,
            // fontFamily: AssetsFonts.InterMedium,
          ),
        ),
      ),
    ).animate().fade(duration: 500.ms);
  }
}
