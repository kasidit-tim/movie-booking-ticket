import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/screens/main/bloc/main_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/views/home_screen.dart';
import 'package:movie_booking_ticket/screens/main/movie/views/movie_screen.dart';
import 'package:movie_booking_ticket/screens/main/profile/views/profile_screen.dart';
import 'package:movie_booking_ticket/screens/main/ticket/views/ticket_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onTap(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MainBloc, MainState>(
        listenWhen: (prev, curr) {
          return prev.page != curr.page;
        },
        listener: (context, state) {
          _onTap(state.page.index);
        },
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            const HomeScreen(),
            const TicketScreen(),
            const MovieScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BlocSelector<MainBloc, MainState, int>(
        selector: (state) {
          return state.page.index;
        },
        builder: (context, selection) {
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.darkGrey, width: 1),
              ),
            ),
            child: NavigationBar(
              backgroundColor: AppColors.black,
              indicatorColor: Colors.transparent,
              selectedIndex: selection,
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return context.textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                  );
                }
                return context.textTheme.titleSmall;
              }),
              onDestinationSelected: (index) {
                final bloc = context.read<MainBloc>();
                bloc.add(NavigateToTabEvent(page: PageTab.values[index]));
              },
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
          );
        },
      ),
    );
  }
}
