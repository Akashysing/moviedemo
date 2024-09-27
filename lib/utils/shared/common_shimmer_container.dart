import 'package:flutter/material.dart';
import 'package:kettomovie/utils/shared/common_shimmer_widget.dart';

class CommonShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const CommonShimmerContainer(
      {super.key, this.width = 50, this.height = 10, this.radius = 5});

  @override
  Widget build(BuildContext context) {
    return CommonShimmerWidget(
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xffE0E0E0),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          )),
    );
  }
}
