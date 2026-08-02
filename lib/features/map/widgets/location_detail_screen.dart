import 'package:flutter/material.dart';
import 'package:pin_point/features/map/data/models/model_location.dart';
import 'package:pin_point/features/map/widgets/location_summary.dart';
import 'package:pin_point/features/map/widgets/location_image_carousel.dart';

import '../../../core/theme/app_theme.dart';

class LocationDetailScreen extends StatelessWidget {
  final ModelLocation location;

  const LocationDetailScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : MediaQuery.of(context).size.height;
        return SizedBox(
            height: height,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.keyboard_arrow_down),
                                color: AppTheme.primaryColor,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: AppTheme.accentColor,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      LocationSummary(location: location),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: callPhone,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: AppTheme.primaryColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: AppTheme.accentColor,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Call',
                                style: TextStyle(color: AppTheme.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (location.imageUrls.isNotEmpty) ...[
                        LocationImageCarousel(imageUrls: location.imageUrls),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(color: AppTheme.textPrimary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${location.description}',
                            style: TextStyle(color: AppTheme.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24,),
                      divider(),
                      const SizedBox(height: 12,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.alarm,
                            color: AppTheme.accentColor,
                            size: 24,
                          ),
                          const SizedBox(width: 4,),
                          Text('Working time',
                            style: TextStyle(color: AppTheme.textPrimary),
                          ),
                          const SizedBox(width: 45,),
                          Expanded(
                            child: Text(
                              '${location.workingHours}',
                              style: TextStyle(color: AppTheme.textPrimary),
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      divider(),
                      const SizedBox(height: 12,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin_drop_rounded,
                            color: AppTheme.accentColor,
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Address ',
                            style: TextStyle(color: AppTheme.textPrimary),
                          ),
                          const SizedBox(width: 25,),
                          Expanded(
                            child: Text(
                              '${location.fullAddress}',
                              style: TextStyle(color: AppTheme.textPrimary),
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ),
          );
      },
    );
  }

  static Widget divider() {
    return const Divider(height: 1, thickness: 1);
  }

  static void callPhone() {
    // TODO: подключить url_launcher для реального звонка
    debugPrint('Call button tapped');
  }
}
