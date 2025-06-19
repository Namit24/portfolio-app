import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExtracurricularSection extends StatelessWidget {
  const ExtracurricularSection({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'title': 'Open Source Contributor',
        'organization': 'Scikit-Learn',
        'description': 'Contributing to one of the most popular machine learning libraries in Python, helping improve algorithms and documentation.',
        'icon': Icons.code,
      },
      {
        'title': 'Tech Community Member',
        'organization': 'Developer Communities',
        'description': 'Active participant in various developer communities, sharing knowledge and learning from peers.',
        'icon': Icons.groups,
      },
      {
        'title': 'Mentor & Guide',
        'organization': 'Peer Mentoring',
        'description': 'Helping fellow developers learn mobile app development and machine learning concepts.',
        'icon': Icons.school,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Extracurricular Activities',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 400.ms),
          
          const SizedBox(height: 16),
          
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return _buildActivityCard(context, activity, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, Map<String, dynamic> activity, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    activity['icon'] as IconData,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'] as String,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        activity['organization'] as String,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              activity['description'] as String,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    ).animate().slideX(
      begin: 0.3,
      delay: Duration(milliseconds: 100 * index),
      duration: 600.ms,
      curve: Curves.easeOutCubic,
    );
  }
}
