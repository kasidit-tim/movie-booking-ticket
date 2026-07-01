import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/screens/main/profile/data/profile_menu_items.dart';
import 'package:movie_booking_ticket/screens/main/profile/models/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap.h32,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 6),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        height: 90,
                        width: 90,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://img.magnific.com/free-photo/horizontal-portrait-smiling-happy-young-pleasant-looking-female-wears-denim-shirt-stylish-glasses-with-straight-blonde-hair-expresses-positiveness-poses_176420-13176.jpg?semt=ais_hybrid&w=740&q=80",
                        ),
                      ),
                    ),
                    Gap.w24,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Angelina",
                          style: context.textTheme.headlineLarge,
                        ),
                        Text(""),
                        Row(
                          children: [
                            Assets.images.profileMenu.call.svg(),
                            Gap.w8,
                            Text(
                              "(704) 555-0127",
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Gap.h4,
                        Row(
                          children: [
                            Assets.images.profileMenu.sms.svg(),
                            Gap.w8,
                            Text(
                              "angelina@example.com",
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {
                        //
                      },
                      child: Assets.images.profileMenu.edit.svg(
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Gap.h64,
              Column(
                children: List.generate(profileMenuItems.length, (i) {
                  return _buildProfileMenuTile(
                    context,
                    item: profileMenuItems[i],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenuTile(
    BuildContext context, {
    required ProfileMenuItem item,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap.h24,
            Row(
              children: [
                SvgPicture.asset(item.iconAsset, height: 32, width: 32),
                Gap.w16,
                Text(item.title, style: context.textTheme.titleMedium),
                Expanded(child: SizedBox()),
                !item.hasSwitch
                    ? Assets.images.profileMenu.arrowRight.svg(
                        height: 24,
                        width: 24,
                      )
                    : CupertinoSwitch(
                        thumbColor: AppColors.primary,
                        activeTrackColor: AppColors.primary,
                        value: false,
                        onChanged: (value) {
                          //
                        },
                      ),
              ],
            ),
            Gap.h24,
            if (!item.hasSwitch) Divider(height: 0, thickness: 0.5),
          ],
        ),
      ),
    );
  }
}
