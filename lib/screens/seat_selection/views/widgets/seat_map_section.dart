import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:movie_booking_ticket/screens/seat_selection/views/widgets/seat_widget.dart';

class SeatConfig {
  static const double size = 28;
  static const double gap = 8;

  static const int rows = 10;
  static const int columns = 12;
}

class SeatMapSection extends StatelessWidget {
  final ValueNotifier<bool> isInteracting;

  const SeatMapSection({super.key, required this.isInteracting});

  static const _mapWidth =
      SeatConfig.columns * (SeatConfig.size + SeatConfig.gap);
  static const _mapHeight =
      SeatConfig.rows * (SeatConfig.size + SeatConfig.gap);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => isInteracting.value = true,
      onPointerUp: (_) => isInteracting.value = false,
      onPointerCancel: (_) => isInteracting.value = false,
      child: const SizedBox(
        height: _mapHeight,
        child: RepaintBoundary(child: _SeatMapViewport()),
      ),
    );
  }
}

class _SeatMapViewport extends StatefulWidget {
  const _SeatMapViewport();

  @override
  State<_SeatMapViewport> createState() => _SeatMapViewportState();
}

class _SeatMapViewportState extends State<_SeatMapViewport> {
  final TransformationController _controller = TransformationController();
  bool _initialized = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!_initialized) {
          final scaleX = constraints.maxWidth / SeatMapSection._mapWidth;
          final scaleY = constraints.maxHeight / SeatMapSection._mapHeight;
          final initialScale = math.min(scaleX, scaleY);
          final dx =
              (constraints.maxWidth - SeatMapSection._mapWidth * initialScale) /
              2;
          final dy =
              (constraints.maxHeight -
                  SeatMapSection._mapHeight * initialScale) /
              2;

          _controller.value = Matrix4.identity()
            ..translateByDouble(dx, dy, 0, 1)
            ..scaleByDouble(initialScale, initialScale, 1, 1);
          _initialized = true;
        }

        return InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(300),
          minScale: 1,
          maxScale: 4,
          transformationController: _controller,
          child: const SizedBox(
            width: SeatMapSection._mapWidth,
            height: SeatMapSection._mapHeight,
            child: SeatMap(),
          ),
        );
      },
    );
  }
}

class SeatMap extends StatelessWidget {
  const SeatMap({super.key});

  static const _rows = SeatConfig.rows;
  static const _cols = SeatConfig.columns;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_rows, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_cols, (col) {
            final seatNo = "${String.fromCharCode(65 + row)}${col + 2}";
            return Padding(
              padding: const EdgeInsets.all(SeatConfig.gap / 2),
              child: SeatWidget(seatNo: seatNo),
            );
          }),
        );
      }),
    );
  }
}
