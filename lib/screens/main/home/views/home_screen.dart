import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/core/widgets/movie_card.dart';
import 'package:movie_booking_ticket/core/widgets/my_textfield.dart';
import 'package:movie_booking_ticket/screens/main/home/views/widgets/carousel_movie_card.dart';
import 'package:movie_booking_ticket/screens/main/home/views/widgets/home_section.dart';
import 'package:movie_booking_ticket/screens/main/home/views/widgets/movie_news.dart';
import 'package:movie_booking_ticket/screens/main/home/views/widgets/movie_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHomeHeader(context),
              Gap.h24,

              _buildHomeSearchBar(),
              Gap.h32,

              HomeSection(title: "Now Playing", child: CarouselMovieCard()),

              HomeSection(
                title: "Coming soon",
                child: _horizonList(
                  child: SizedBox(
                    width: 175,
                    child: MovieCard(showRatingStar: false),
                  ),
                ),
              ),

              HomeSection(
                title: "Promo & Discount",
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint("=====> promo");
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 225,
                        imageUrl:
                            "https://i.ytimg.com/vi/CjAXOiKz9jw/maxresdefault.jpg",
                      ),
                    ),
                  ),
                ),
              ),

              HomeSection(
                title: "Service",
                child: _horizonList(child: MovieServices()),
              ),

              HomeSection(
                title: "Movie news",
                child: _horizonList(child: MovieNews()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi, Angelina 👋", style: context.textTheme.bodyLarge),
              Text("Welcome back", style: context.textTheme.headlineSmall),
            ],
          ),
          Icon(Icons.notification_add),
        ],
      ),
    );
  }

  Widget _buildHomeSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MyTextfield(),
    );
  }

  Widget _horizonList({required Widget child}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(10, (i) {
            return Padding(
              padding: EdgeInsets.only(left: i == 0 ? 16 : 0, right: 16),
              child: child,
            );
          }),
        ],
      ),
    );
  }
}
