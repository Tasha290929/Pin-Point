import 'package:flutter/material.dart';

class ModelProfileMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ModelProfileMenuItem({
    required this.icon,
    required this.title,
    this.onTap,
  });
}
