import 'package:flutter/material.dart';
import 'package:pin_point/features/map/data/models/model_location.dart';
import 'package:pin_point/features/map/widgets/location_summary.dart';

import '../../../core/theme/app_theme.dart';

class LocationDetailScreen extends StatelessWidget {
  final ModelLocation location;

  const LocationDetailScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
      height: constraints.maxHeight,
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
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor.withOpacity(0.3),
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
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      side: BorderSide(color: AppTheme.primaryColor),
                    ),
                    child: Container(
                      color: AppTheme.surfaceColor,
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppTheme.accentColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Call',
                            style: TextStyle(color: AppTheme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'About',
                      style: TextStyle(color: AppTheme.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      child: Text(
                        '${location.description}',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                    ),
                  ],
                ),
                divider(),
              ],
            ),
          ),
      ),
    );
      },
    );
  }

  static Widget divider() {
    return const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16);
  }

  static void callPhone() {
    // TODO: подключить url_launcher для реального звонка
    debugPrint('Call button tapped');
  }
}
