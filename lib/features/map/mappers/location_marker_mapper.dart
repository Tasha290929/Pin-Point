import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pin_point/core/theme/app_theme.dart';
import 'package:pin_point/features/map/data/models/model_location.dart';

class LocationMarkerMapper {
  static const double _displaySize = 44;
  static const double _renderScale = 3;
  static const double _iconFillFactor = 0.68;

  static Future<Marker> toMarker(
      ModelLocation location, {
        required void Function(ModelLocation) onTap,
      }) async {
    final icon = await _loadIcon(location.iconAsset);

    return Marker(
      markerId: MarkerId(location.id),
      position: LatLng(location.latitude, location.longitude),
      infoWindow: InfoWindow(title: location.name),
      onTap: () => onTap(location),
      icon: icon,
    );
  }

  static Future<Set<Marker>> toMarkerSet(
      List<ModelLocation> locations, {
        required void Function(ModelLocation) onTap,
      }) async {
    final results = await Future.wait(
      locations.map((loc) async {
        try {
          return await toMarker(loc, onTap: onTap);
        } catch (e) {
          debugPrint('Failed to create marker for ${loc.id}: $e');
          return null;
        }
      }),
    );

    return results.whereType<Marker>().toSet();
  }

  static Future<BitmapDescriptor> _loadIcon(String? iconAsset) async {
    try {
      final path = 'assets/images/$iconAsset';

      final loader = SvgAssetLoader(path, assetBundle: rootBundle);
      final pictureInfo = await vg.loadPicture(loader, null);

      final renderSize = _displaySize * _renderScale;
      final center = ui.Offset(renderSize / 2, renderSize / 2);
      final strokeWidth = renderSize * 0.035;
      final radius = renderSize / 2 - strokeWidth / 2;

      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(
        recorder,
        ui.Rect.fromLTWH(0, 0, renderSize, renderSize),
      );

      canvas.drawCircle(
        center,
        radius,
        ui.Paint()..color = AppTheme.backgroundColor,
      );
      canvas.drawCircle(
        center,
        radius,
        ui.Paint()
          ..color = const ui.Color(0x33000000)
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = strokeWidth,
      );


      final naturalSize = pictureInfo.size;
      final logoBox = renderSize * _iconFillFactor;
      final scale = logoBox /
          (naturalSize.width > naturalSize.height
              ? naturalSize.width
              : naturalSize.height);
      final scaledWidth = naturalSize.width * scale;
      final scaledHeight = naturalSize.height * scale;

      canvas.save();
      canvas.translate(
        center.dx - scaledWidth / 2,
        center.dy - scaledHeight / 2,
      );
      canvas.scale(scale);
      canvas.drawPicture(pictureInfo.picture);
      canvas.restore();

      final badge = recorder.endRecording();
      final image = await badge.toImage(
        renderSize.toInt(),
        renderSize.toInt(),
      );
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      pictureInfo.picture.dispose();
      badge.dispose();
      image.dispose();

      if (byteData == null) {
        throw Exception('Failed to convert SVG to bytes');
      }

      return BitmapDescriptor.bytes(
        byteData.buffer.asUint8List(),
        width: _displaySize,
        height: _displaySize,
      );
    } catch (e) {
      debugPrint('Error loading icon $iconAsset: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }
}