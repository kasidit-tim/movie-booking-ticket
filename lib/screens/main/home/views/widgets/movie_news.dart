import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';

class MovieNews extends StatelessWidget {
  const MovieNews({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("====> movie news");
      },
      child: SizedBox(
        width: 240,
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: 135,
                width: 239,
                imageUrl:
                    "https://i.ytimg.com/vi/VKuww279Mwk/maxresdefault.jpg",
              ),
            ),
            Gap.h20,
            Text(
              "When The Batman 2 Starts Filming Reportedly Revealed",
              style: context.textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
