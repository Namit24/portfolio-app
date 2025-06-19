import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'premium_glassmorphic_card.dart';

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
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Tech Community Member',
        'organization': 'Developer Communities',
        'description': 'Active participant in various developer communities, sharing knowledge and learning from peers.',
        'icon': Icons.groups,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'title': 'Mentor & Guide',
        'organization': 'Peer Mentoring',
        'description': 'Helping fellow developers learn mobile app development and machine learning concepts.',
        'icon': Icons.school,
        'color': const Color(0xFF06B6D4),
      },
    ];

    final interests = [
      {'name': 'Photography', 'icon': Icons.camera_alt, 'color': const Color(0xFFEC4899)},
      {'name': 'Creative Writing', 'icon': Icons.edit, 'color': const Color(0xFF8B5CF6)},
      {'name': 'Canva Design', 'icon': Icons.design_services, 'color': const Color(0xFF06B6D4)},
      {'name': 'Tech Innovation', 'icon': Icons.lightbulb, 'color': const Color(0xFFF59E0B)},
      {'name': 'Problem Solving', 'icon': Icons.psychology, 'color': const Color(0xFF10B981)},
      {'name': 'Learning', 'icon': Icons.auto_stories, 'color': const Color(0xFFEF4444)},
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFEC4899).withOpacity(0.08),
            const Color(0xFF8B5CF6).withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 16), // FIXED: Top padding for app bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER SECTION
            PremiumGlassmorphicCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.groups_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16), // ORGANIZED: Consistent spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Extracurricular Activities',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4), // ORGANIZED: Small spacing
                        Text(
                          'Community involvement & leadership',
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

            const SizedBox(height: 24), // ORGANIZED: Section spacing

            // ACTIVITIES LIST
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16), // ORGANIZED: Consistent spacing
              itemBuilder: (context, index) {
                final activity = activities[index];
                return _buildActivityCard(context, activity, index);
              },
            ),

            const SizedBox(height: 24), // ORGANIZED: Section spacing

            // INTERESTS & HOBBIES SECTION
            PremiumGlassmorphicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12), // ORGANIZED: Consistent spacing
                      Text(
                        'Interests & Hobbies',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // ORGANIZED: Content spacing

                  // Interests Grid
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
                            const SizedBox(width: 8), // ORGANIZED: Icon spacing
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

            const SizedBox(height: 24), // ORGANIZED: Section spacing

            // ACHIEVEMENTS SECTION
            PremiumGlassmorphicCard(
              isHoverable: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF059669)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12), // ORGANIZED: Consistent spacing
                      Text(
                        'Key Achievements',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // ORGANIZED: Content spacing

                  // Achievements List
                  Column(
                    children: [
                      _buildAchievementItem(
                        context,
                        'Open Source Impact',
                        'Contributed to Scikit-Learn with meaningful code improvements',
                        Icons.code,
                        const Color(0xFF10B981),
                      ),
                      const SizedBox(height: 12), // ORGANIZED: Item spacing
                      _buildAchievementItem(
                        context,
                        'Community Leadership',
                        'Mentored 10+ developers in mobile and ML development',
                        Icons.people,
                        const Color(0xFF8B5CF6),
                      ),
                      const SizedBox(height: 12), // ORGANIZED: Item spacing
                      _buildAchievementItem(
                        context,
                        'Knowledge Sharing',
                        'Active participant in tech communities and forums',
                        Icons.share,
                        const Color(0xFF06B6D4),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().slideY(
              begin: 0.3,
              delay: 800.ms,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),

            const SizedBox(height: 40), // ORGANIZED: Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, Map<String, dynamic> activity, int index) {
    return PremiumGlassmorphicCard(
      isHoverable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activity Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (activity['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: (activity['color'] as Color).withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: activity['color'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16), // ORGANIZED: Consistent spacing
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
                    const SizedBox(height: 4), // ORGANIZED: Small spacing
                    Text(
                      activity['organization'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: activity['color'] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // ORGANIZED: Content spacing

          // Activity Description
          Text(
            activity['description'] as String,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate(delay: Duration(milliseconds: 200 + index * 100)).slideX(
      begin: 0.3,
      duration: 600.ms,
      curve: Curves.easeOutCubic,
    ).fadeIn(duration: 400.ms);
  }

  Widget _buildAchievementItem(
      BuildContext context,
      String title,
      String description,
      IconData icon,
      Color color,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        ),
        const SizedBox(width: 12), // ORGANIZED: Content spacing
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 4), // ORGANIZED: Small spacing
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
