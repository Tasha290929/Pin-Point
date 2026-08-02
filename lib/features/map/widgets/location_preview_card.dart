import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_point/core/theme/app_theme.dart';
import 'package:pin_point/features/map/data/models/model_location.dart';
import 'package:pin_point/features/map/widgets/location_summary.dart';

class LocationPreviewCard extends StatelessWidget {
  final ModelLocation location;
  final VoidCallback onClose;
  final VoidCallback onDetails;
  final VoidCallback onNavigate;

  const LocationPreviewCard({
    super.key,
    required this.location,
    required this.onClose,
    required this.onDetails,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width * 0.48;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 12),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          LocationSummary(
            location: location,
            imageSize: imageSize,
            action: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onDetails,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  side: BorderSide(color: AppTheme.primaryColor),
                ),
                child: Text('Details', style: TextStyle(color: AppTheme.primaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
