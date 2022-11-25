import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';



class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.transparent,
        period : const Duration(milliseconds: 1000),
        highlightColor: Colors.white10,
        child: Container(
          color: backgroundColor,
        ));
  }
}
