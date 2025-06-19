import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skillCategories = {
      'Programming Languages': [
        {'name': 'Python', 'level': 0.9},
        {'name': 'Dart', 'level': 0.85},
        {'name': 'Kotlin', 'level': 0.8},
        {'name': 'C++', 'level': 0.75},
        {'name': 'SQL', 'level': 0.8},
      ],
      'Frameworks & Tools': [
        {'name': 'Flutter', 'level': 0.9},
        {'name': 'Firebase', 'level': 0.85},
        {'name': 'Git', 'level': 0.9},
        {'name': 'Linux', 'level': 0.8},
        {'name': 'Transformers', 'level': 0.75},
      ],
      'Specializations': [
        {'name': 'Machine Learning', 'level': 0.9},
        {'name': 'App Development', 'level': 0.9},
        {'name': 'Data Science', 'level': 0.8},
        {'name': 'DBMS', 'level': 0.75},
      ],
    };

    final interests = [
      {'name': 'Photography', 'icon': Icons.camera_alt},
      {'name': 'Creative Writing', 'icon': Icons.edit},
      {'name': 'Canva Design', 'icon': Icons.design_services},
      {'name': 'Tech Innovation', 'icon': Icons.lightbulb},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills & Expertise',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Skills Categories
          Column(
            children: skillCategories.entries.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.key,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...category.value.map((skill) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        skill['name'] as String,
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${((skill['level'] as double) * 100).toInt()}%',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: skill['level'] as double,
                                    backgroundColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(), // Important: convert to List
          ).animate().slideX(
            begin: 0.3,
            duration: 600.ms,
            curve: Curves.easeOutCubic,
          ),


          // Interests Section
          Text(
            'Interests & Hobbies',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  final interest = interests[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          interest['icon'] as IconData,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          interest['name'] as String,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ).animate().slideY(
            begin: 0.3,
            delay: 600.ms,
            duration: 600.ms,
            curve: Curves.easeOutCubic,
          ),
        ],
      ),
    );
  }
}
