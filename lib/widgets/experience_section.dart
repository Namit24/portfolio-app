import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/experience.dart';
import '../data/experience_data.dart';
import 'premium_glassmorphic_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 1.5,
          colors: [
            const Color(0xFF8B5CF6).withOpacity(0.08),
            const Color(0xFF06B6D4).withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 20), // FIXED: Top padding for app bar
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
                        colors: [Color(0xFF8B5CF6), Color(0xFF06B6D4)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.business_center_outlined,
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
                          'Professional Experience',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4), // ORGANIZED: Small spacing
                        Text(
                          'Career journey & achievements',
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

            // EXPERIENCE LIST
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ExperienceData.experiences.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16), // ORGANIZED: Consistent spacing
              itemBuilder: (context, index) {
                final experience = ExperienceData.experiences[index];
                return _buildExperienceCard(context, experience, index);
              },
            ),

            const SizedBox(height: 24), // ORGANIZED: Section spacing

            // CAREER HIGHLIGHTS SECTION
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
                          Icons.star_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12), // ORGANIZED: Consistent spacing
                      Text(
                        'Career Highlights',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // ORGANIZED: Content spacing

                  // Highlights Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildHighlightItem(
                          context,
                          'Open Source',
                          'Contributor',
                          Icons.code,
                          const Color(0xFF8B5CF6),
                        ),
                      ),
                      const SizedBox(width: 12), // ORGANIZED: Grid spacing
                      Expanded(
                        child: _buildHighlightItem(
                          context,
                          'Data Science',
                          'Specialist',
                          Icons.analytics,
                          const Color(0xFF06B6D4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().slideY(
              begin: 0.3,
              delay: 600.ms,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),

            const SizedBox(height: 40), // ORGANIZED: Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, Experience experience, int index) {
    final gradients = [
      [const Color(0xFF8B5CF6), const Color(0xFF06B6D4)],
      [const Color(0xFF10B981), const Color(0xFF059669)],
    ];

    final gradient = gradients[index % gradients.length];

    return PremiumGlassmorphicCard(
      isHoverable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Experience Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: gradient[0].withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  experience.icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16), // ORGANIZED: Consistent spacing
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.position,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4), // ORGANIZED: Small spacing
                    Text(
                      experience.company,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: gradient[0],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2), // ORGANIZED: Tiny spacing
                    Text(
                      experience.duration,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // ORGANIZED: Content spacing

          // Experience Description
          Text(
            experience.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),

          // Achievements Section
          if (experience.achievements.isNotEmpty) ...[
            const SizedBox(height: 16), // ORGANIZED: Content spacing
            Text(
              'Key Achievements:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: gradient[0],
              ),
            ),
            const SizedBox(height: 8), // ORGANIZED: Small spacing
            ...experience.achievements.map((achievement) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: gradient[0].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: gradient[0],
                      ),
                    ),
                    const SizedBox(width: 12), // ORGANIZED: Content spacing
                    Expanded(
                      child: Text(
                        achievement,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    ).animate(delay: Duration(milliseconds: 200 + index * 100)).slideY(
      begin: 30,
      duration: 600.ms,
      curve: Curves.easeOutCubic,
    ).fadeIn(duration: 400.ms);
  }

  Widget _buildHighlightItem(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8), // ORGANIZED: Small spacing
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4), // ORGANIZED: Tiny spacing
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
