import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  const BaseShimmer(
      {super.key, required this.child, this.highlightColor = false});
  final Widget child;
  final bool highlightColor;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Shimmer.fromColors(
        enabled: true,
        direction: ShimmerDirection.ltr,
        baseColor: Theme.of(context).primaryColor,
        highlightColor:
            highlightColor ? Colors.red : Color.fromARGB(65, 255, 255, 255),
        child: child,
      ),
    );
  }
}
