import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/widgets/my_seperator.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

class PerforatedDivider extends StatelessWidget {
  const PerforatedDivider({super.key});

  static const _circleSize = 48.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.images.general.semiCircle.svg(
          height: _circleSize,
          width: _circleSize,
        ),
        const Expanded(child: MySeparator(height: 0.5)),
        Transform.rotate(
          angle: math.pi,
          child: Assets.images.general.semiCircle.svg(
            height: _circleSize,
            width: _circleSize,
          ),
        ),
      ],
    );
  }
}
