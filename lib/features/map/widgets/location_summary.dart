import 'package:flutter/material.dart';
import 'package:pin_point/features/map/widgets/location_image.dart';

import '../../../core/theme/app_theme.dart';
import '../data/models/model_location.dart';
import 'open_status.dart';

class LocationSummary extends StatelessWidget {
  final ModelLocation location;
  final double imageSize;
  final Widget? action;
  const LocationSummary({
    super.key,
    required this.location,
    this.imageSize = 120,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      LocationImage(location: location, imageSize: imageSize,),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      location.name,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text('${location.rating}'),
                ],
              ),

              const SizedBox(height: 12),
              Text(
                'Category: ${location.category}',
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 6),
              OpenStatus(workingHours: location.workingHours),
              if (action != null) ...[
                const SizedBox(height: 16),
                action!,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
