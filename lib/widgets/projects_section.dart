import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/project.dart';
import '../data/projects_data.dart';
import 'premium_glassmorphic_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF764BA2).withOpacity(0.1),
            const Color(0xFF667EEA).withOpacity(0.1),
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
                        colors: [Color(0xFF764BA2), Color(0xFF667EEA)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.work_outline,
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
                          'Selected Works',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4), // ORGANIZED: Small spacing
                        Text(
                          'Featured projects & contributions',
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

            // PROJECTS LIST
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ProjectsData.projects.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16), // ORGANIZED: Consistent spacing
              itemBuilder: (context, index) {
                final project = ProjectsData.projects[index];
                return _buildProjectCard(context, project, index);
              },
            ),

            const SizedBox(height: 40), // ORGANIZED: Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index) {
    final gradients = [
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFF00D4AA), const Color(0xFF00B4D8)],
      [const Color(0xFFEC4899), const Color(0xFF8B5CF6)],
      [const Color(0xFFF59E0B), const Color(0xFFEF4444)],
    ];

    final gradient = gradients[index % gradients.length];

    return PremiumGlassmorphicCard(
      isHoverable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  project.icon,
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
                      project.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4), // ORGANIZED: Small spacing
                    Text(
                      project.role,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: gradient[0],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: gradient[0].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Details',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: gradient[0],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // ORGANIZED: Content spacing

          // Project Description
          Text(
            project.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16), // ORGANIZED: Content spacing

          // Technologies
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.technologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: gradient[1].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: gradient[1].withOpacity(0.3),
                  ),
                ),
                child: Text(
                  tech,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: gradient[1],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate(delay: Duration(milliseconds: 200 + index * 100)).slideY(
      begin: 30,
      duration: 600.ms,
      curve: Curves.easeOutCubic,
    ).fadeIn(duration: 400.ms);
  }
}
