import 'package:flutter/material.dart';

import '../data/models/model_location.dart';

class LocationImage extends StatelessWidget {
  final ModelLocation location;
  final double? imageSize;
  final double borderRadius;

  const LocationImage({
    super.key,
    required this.location,
    this.imageSize,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: imageSize,
        height: imageSize,
        child: location.mainImage != null
            ? Image.network(location.mainImage!, fit: BoxFit.cover)
            : Image.asset(
          'assets/images/no_image.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
