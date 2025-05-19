import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_app/theme/app_colors.dart';

class ExperienceCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String duration;
  final List<String> description;
  final int animationDelay;

  const ExperienceCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.duration,
    required this.description,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.teal,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              company,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: AppColors.darkGray,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGray,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.darkGray,
                ),
                const SizedBox(width: 4),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGray,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...description.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_right,
                        color: AppColors.teal,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          point,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: animationDelay.ms).slideY(begin: 0.2, end: 0);
  }
}
