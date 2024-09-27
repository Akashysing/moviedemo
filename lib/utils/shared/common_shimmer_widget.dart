import 'package:flutter/material.dart';
import 'package:kettomovie/utils/shared/shimmer.dart';

class CommonShimmerWidget extends StatelessWidget {
  final Widget child;

  const CommonShimmerWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffE0E0E0),
      highlightColor: const Color(0xffF5F5F5),
      child: child,
    );
  }
}
