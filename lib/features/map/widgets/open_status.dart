import 'package:flutter/material.dart';
import 'package:pin_point/core/theme/app_theme.dart';
import 'package:pin_point/core/utils/working_hours_helper.dart';

class OpenStatus extends StatelessWidget {
  final String? workingHours;
  const OpenStatus({super.key, this.workingHours});

  @override
  Widget build(BuildContext context) {
    final isOpen = WorkingHoursHelper.isOpenNow(workingHours);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isOpen ? AppTheme.accentColor : AppTheme.error,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4,),
        Text(
          isOpen ? 'Open now' : 'Closed',
          style: TextStyle(
            color: isOpen ? AppTheme.accentColor : AppTheme.error,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
