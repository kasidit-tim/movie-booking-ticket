import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.darkGrey, width: 1)),
        ),
        child: NavigationBar(
          backgroundColor: AppColors.black,
          indicatorColor: Colors.transparent,
          selectedIndex: navigationShell.currentIndex,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return context.textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
              );
            }
            return context.textTheme.titleSmall;
          }),
          onDestinationSelected: _onTap,
          destinations: [
            NavigationDestination(
              icon: Assets.images.navBar.home.svg(),
              selectedIcon: Assets.images.navBar.homeActive.svg(),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Assets.images.navBar.ticket.svg(),
              selectedIcon: Assets.images.navBar.ticketActive.svg(),
              label: 'Ticket',
            ),
            NavigationDestination(
              icon: Assets.images.navBar.video.svg(),
              selectedIcon: Assets.images.navBar.videoActive.svg(),
              label: 'Movie',
            ),
            NavigationDestination(
              icon: Assets.images.navBar.user.svg(),
              selectedIcon: Assets.images.navBar.userActive.svg(),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
