import 'package:flutter/material.dart';
import 'package:pin_point/features/profile/data/models/model_profile.dart';
import 'package:pin_point/features/profile/data/models/model_profile_menu_item.dart';

class MockProfile {
  static const ModelProfile current = ModelProfile(
    name: 'John Smith',
    avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
    email: 'jawem23190@aghism.com',
    phone: '060 123 456',
    city: 'Chișinău, Moldova',
  );

  static final List<ModelProfileMenuItem> items = [
    ModelProfileMenuItem(
      icon: Icons.settings_outlined,
      title: 'Settings',
      onTap: () {},
    ),
    ModelProfileMenuItem(
      icon: Icons.help_outline,
      title: 'Help & support',
      onTap: () {},
    ),
    ModelProfileMenuItem(
      icon: Icons.logout,
      title: 'Log out',
      onTap: () {},
    ),
  ];
}