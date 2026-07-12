import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/widgets/movie_card.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_paginate_data.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';
import 'package:movie_booking_ticket/screens/main/movie/data/movie_section_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key, required this.tab});

  final MovieTab tab;

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 200) {
      return;
    }

    final bloc = context.read<MovieBloc>();
    final section = widget.tab == MovieTab.nowPlaying
        ? bloc.state.nowPlaying
        : bloc.state.comingSoon;

    if (section.isLoadingMore) return;
    if (!_hasMorePages(section.movies)) return;

    bloc.add(LoadMoreMoviesEvent(tab: widget.tab));
  }

  bool _hasMorePages(MoviePaginateData data) {
    return (data.page ?? 0) < (data.totalPages ?? 0);
  }

  int _placeholderCount(int length) {
    return length.isEven ? 2 : 3;
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 24,
      childAspectRatio: widget.tab == MovieTab.comingSoon ? 0.47 : 0.44,
    );
  }

  MovieSectionState _section(MovieState state) {
    return switch (widget.tab) {
      MovieTab.nowPlaying => state.nowPlaying,
      MovieTab.comingSoon => state.comingSoon,
    };
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (prev, curr) {
        return _section(prev) != _section(curr);
      },
      builder: (context, state) {
        final section = _section(state);
        final movies = section.movies.results ?? [];

        if (section.isLoading) {
          return _buildSkeletonGrid();
        }

        if (movies.isEmpty) {
          return const SizedBox();
        }

        return CustomScrollView(
          key: PageStorageKey(widget.tab),
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    if (i >= movies.length) {
                      return Skeletonizer(
                        enabled: true,
                        child: MovieCard(
                          data: MovieDataModel(title: 'Loading'),
                        ),
                      );
                    }
                    return MovieCard(
                      data: movies[i],
                      isComingSoon: widget.tab == MovieTab.comingSoon,
                    );
                  },
                  childCount: section.isLoadingMore
                      ? movies.length + _placeholderCount(movies.length)
                      : movies.length,
                ),
                gridDelegate: _gridDelegate(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSkeletonGrid() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: _gridDelegate(),
        itemBuilder: (context, i) =>
            MovieCard(data: MovieDataModel(title: 'Loading')),
      ),
    );
  }
}
