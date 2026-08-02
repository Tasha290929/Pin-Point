// lib/features/profile/widgets/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:pin_point/core/theme/app_theme.dart';
import 'package:pin_point/features/profile/data/mock/mock_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = MockProfile.current;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppTheme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar + name + role
            Stack(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profile.avatarUrl != null
                      ? NetworkImage(profile.avatarUrl!)
                      : null,
                  child: profile.avatarUrl == null
                      ? const Icon(Icons.person, size: 48)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              profile.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 24),

            // Contact info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _InfoRow(icon: Icons.email_outlined, label: 'Email', value: profile.email),
                  const Divider(height: 24),
                  _InfoRow(icon: Icons.phone_outlined, label: 'Phone', value: profile.phone),
                  const Divider(height: 24),
                  _InfoRow(icon: Icons.location_on_outlined, label: 'Current city', value: profile.city),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Menu items
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: MockProfile.items.map((item) {
                  final isLast = item == MockProfile.items.last;
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(item.icon, color: AppTheme.primaryColor),
                        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: item.onTap,
                      ),
                      if (!isLast) const Divider(height: 1, indent: 16, endIndent: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}