import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_app/theme/app_colors.dart';

class AwardItem extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final int animationDelay;

  const AwardItem({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.emoji_events,
              color: AppColors.teal,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGray,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: animationDelay.ms).slideY(begin: 0.2, end: 0);
  }
}
