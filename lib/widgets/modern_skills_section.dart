import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'glassmorphic_card.dart';

class ModernSkillsSection extends StatelessWidget {
  const ModernSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skillCategories = {
      'Programming Languages': [
        {'name': 'Python', 'level': 0.9, 'color': const Color(0xFF10B981)},
        {'name': 'Dart', 'level': 0.85, 'color': const Color(0xFF06B6D4)},
        {'name': 'Kotlin', 'level': 0.8, 'color': const Color(0xFF8B5CF6)},
        {'name': 'C++', 'level': 0.75, 'color': const Color(0xFFF59E0B)},
      ],
      'Frameworks & Tools': [
        {'name': 'Flutter', 'level': 0.9, 'color': const Color(0xFF3B82F6)},
        {'name': 'Firebase', 'level': 0.85, 'color': const Color(0xFFEF4444)},
        {'name': 'Git', 'level': 0.9, 'color': const Color(0xFF6B7280)},
        {'name': 'Linux', 'level': 0.8, 'color': const Color(0xFF059669)},
      ],
    };

    final interests = [
      {'name': 'Photography', 'icon': Icons.camera_alt, 'color': const Color(0xFFEC4899)},
      {'name': 'Creative Writing', 'icon': Icons.edit, 'color': const Color(0xFF8B5CF6)},
      {'name': 'Canva Design', 'icon': Icons.design_services, 'color': const Color(0xFF06B6D4)},
      {'name': 'Tech Innovation', 'icon': Icons.lightbulb, 'color': const Color(0xFFF59E0B)},
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF00D4AA).withOpacity(0.1),
            const Color(0xFF667EEA).withOpacity(0.1),
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skills Header
            GlassmorphicCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00D4AA), Color(0xFF00B4D8)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.code,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SkillSet',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          'Technical expertise & proficiency',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // Skills Categories - FIXED ANIMATION
            ...skillCategories.entries.map((category) {
              return Column(
                children: [
                  GlassmorphicCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.key,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...category.value.map((skill) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      skill['name'] as String,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF374151),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: (skill['color'] as Color).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '${((skill['level'] as double) * 100).toInt()}%',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: skill['color'] as Color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: skill['level'] as double,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            skill['color'] as Color,
                                            (skill['color'] as Color).withOpacity(0.7),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).map((widget) => widget.animate().slideX(
              begin: 0.3,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            )),

            // Interests Section
            GlassmorphicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Interests & Hobbies',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: interests.map((interest) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: (interest['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: (interest['color'] as Color).withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              interest['icon'] as IconData,
                              color: interest['color'] as Color,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              interest['name'] as String,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: interest['color'] as Color,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ).animate().slideY(
              begin: 0.3,
              delay: 600.ms,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
          ],
        ),
      ),
    );
  }
}
