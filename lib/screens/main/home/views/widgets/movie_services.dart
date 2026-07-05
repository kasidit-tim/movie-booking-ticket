import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';

class MovieServices extends StatelessWidget {
  const MovieServices({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("====> movie services");
      },
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: "https://www.cineseatofficial.com/img/Slider-img5.jpg",
            ),
          ),
          Gap.h20,
          Text("Retal", style: context.textTheme.titleMedium),
        ],
      ),
    );
  }
}
