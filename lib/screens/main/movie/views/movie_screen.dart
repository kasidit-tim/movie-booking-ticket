import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/widgets/movie_card.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';
import 'package:movie_booking_ticket/screens/main/movie/views/widgets/movie_tab_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final _scrollController = ScrollController();
  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 24,
    childAspectRatio: 0.44,
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final bloc = context.read<MovieBloc>();
      final state = bloc.state;
      if (state.isLoadingMore) return;

      final hasMorePages =
          (state.nowPlayingMovies.page ?? 0) <
          (state.nowPlayingMovies.totalPages ?? 0);
      if (!hasMorePages) return;
      bloc.add(LoadMoreNowPlayingEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gap.h16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.card,
                ),
                child: BlocBuilder<MovieBloc, MovieState>(
                  buildWhen: (previous, current) => previous.tab != current.tab,
                  builder: (context, state) {
                    final bloc = context.read<MovieBloc>();

                    return Row(
                      children: [
                        MovieTabButton(
                          title: 'Now Playing',
                          tab: MovieTab.nowPlaying,
                          isSelected: state.tab == MovieTab.nowPlaying,
                          onTap: () => bloc.add(
                            const ChangeTabEvent(tab: MovieTab.nowPlaying),
                          ),
                        ),
                        MovieTabButton(
                          title: 'Coming Soon',
                          tab: MovieTab.commingSoon,
                          isSelected: state.tab == MovieTab.commingSoon,
                          onTap: () => bloc.add(
                            const ChangeTabEvent(tab: MovieTab.commingSoon),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Gap.h32,
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                buildWhen: (prev, curr) {
                  return prev.tab != curr.tab ||
                      prev.isNowPlayingLoading != curr.isNowPlayingLoading ||
                      prev.isLoadingMore != curr.isLoadingMore ||
                      prev.nowPlayingMovies.results !=
                          curr.nowPlayingMovies.results;
                },
                builder: (context, state) {
                  if (state.isNowPlayingLoading) {
                    return _buildSkeletonGrid();
                  }
                  if (state.nowPlayingMovies.results?.isEmpty ?? false) {
                    return SizedBox();
                  }

                  final movieList = state.tab == MovieTab.nowPlaying
                      ? state.nowPlayingMovies.results ?? []
                      : [];

                  return CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) => MovieCard(data: movieList[i]),
                            childCount: movieList.length,
                          ),
                          gridDelegate: _gridDelegate,
                        ),
                      ),
                      if (state.isLoadingMore)
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, i) => _buildSkeletonCard(),
                              childCount: 2,
                            ),
                            gridDelegate: _gridDelegate,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Skeletonizer(
      enabled: true,
      child: MovieCard(data: MovieDataModel(title: 'Loading')),
    );
  }

  Widget _buildSkeletonGrid() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: _gridDelegate,
        itemBuilder: (context, i) =>
            MovieCard(data: MovieDataModel(title: 'Loading')),
      ),
    );
  }
}
