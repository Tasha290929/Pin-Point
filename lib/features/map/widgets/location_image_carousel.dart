import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class LocationImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double height;

  const LocationImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 200,
  });

  @override
  State<LocationImageCarousel> createState() => _LocationImageCarouselState();
}

class _LocationImageCarouselState extends State<LocationImageCarousel> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.imageUrls.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imageUrls[i],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        if (widget.imageUrls.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (i) {
              final active = i == _index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: active ? 8 : 6,
                height: active ? 8 : 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active
                      ? AppTheme.accentColor
                      : AppTheme.accentColor.withValues(alpha: 0.3),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}
