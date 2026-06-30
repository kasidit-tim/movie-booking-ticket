// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/nav_bar
  $AssetsImagesNavBarGen get navBar => const $AssetsImagesNavBarGen();
}

class $AssetsImagesNavBarGen {
  const $AssetsImagesNavBarGen();

  /// File path: assets/images/nav_bar/home.svg
  SvgGenImage get home => const SvgGenImage('assets/images/nav_bar/home.svg');

  /// File path: assets/images/nav_bar/home_active.svg
  SvgGenImage get homeActive =>
      const SvgGenImage('assets/images/nav_bar/home_active.svg');

  /// File path: assets/images/nav_bar/ticket.svg
  SvgGenImage get ticket =>
      const SvgGenImage('assets/images/nav_bar/ticket.svg');

  /// File path: assets/images/nav_bar/ticket_active.svg
  SvgGenImage get ticketActive =>
      const SvgGenImage('assets/images/nav_bar/ticket_active.svg');

  /// File path: assets/images/nav_bar/user.svg
  SvgGenImage get user => const SvgGenImage('assets/images/nav_bar/user.svg');

  /// File path: assets/images/nav_bar/user_active.svg
  SvgGenImage get userActive =>
      const SvgGenImage('assets/images/nav_bar/user_active.svg');

  /// File path: assets/images/nav_bar/video.svg
  SvgGenImage get video => const SvgGenImage('assets/images/nav_bar/video.svg');

  /// File path: assets/images/nav_bar/video_active.svg
  SvgGenImage get videoActive =>
      const SvgGenImage('assets/images/nav_bar/video_active.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    home,
    homeActive,
    ticket,
    ticketActive,
    user,
    userActive,
    video,
    videoActive,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
