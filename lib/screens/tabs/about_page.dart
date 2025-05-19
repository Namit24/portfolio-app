import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_app/theme/app_colors.dart';
import 'package:portfolio_app/utils/url_launcher_utils.dart';
import 'package:portfolio_app/widgets/animated_skill_chip.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.mint,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: AppColors.teal,
                      ),
                    );
                  },
                ),
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).scale(),
          const SizedBox(height: 24),
          Text(
            'Hello, I\'m Namit',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.teal,
              fontSize: 24,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideX(begin: -0.2, end: 0),
          const SizedBox(height: 16),
          Text(
            'I\'m a Developer and Data Scientist passionate about building innovative solutions. My expertise spans Machine Learning, App Development, and Data Science.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
              fontSize: 16,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          const SizedBox(height: 24),
          _buildSkillsSection(context),
          const SizedBox(height: 24),
          _buildInterestsSection(context),
          const SizedBox(height: 24),
          _buildContactSection(context),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final skills = [
      'Machine Learning',
      'Data Science',
      'App Development',
      'Microsoft Office',
      'Git',
      'GitHub',
      'C++',
      'Python',
      'Kotlin',
      'Firebase',
      'SQL',
      'Transformers',
      'Linux',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.teal,
            fontSize: 20,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            return AnimatedSkillChip(
              label: skill,
              delay: 600 + (index * 50),
              color: AppColors.mint,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInterestsSection(BuildContext context) {
    final interests = [
      'Photography',
      'Creative Writing',
      'Canva Designing',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.teal,
            fontSize: 20,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 700.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: interests.asMap().entries.map((entry) {
            final index = entry.key;
            final interest = entry.value;
            return AnimatedSkillChip(
              label: interest,
              delay: 800 + (index * 50),
              color: AppColors.yellow,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.teal,
            fontSize: 20,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 900.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 12),
        ListTile(
          leading: Icon(Icons.email, color: AppColors.teal),
          title: Text(
            'Email',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            'namitsolanki48@gmail.com',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () => UrlLauncherUtils.launchUrl('mailto:namitsolanki48@gmail.com'),
        ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideX(begin: 0.2, end: 0),
        ListTile(
          leading: Icon(Icons.link, color: AppColors.teal),
          title: Text(
            'LinkedIn',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            'linkedin.com/in/namit-solanki',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () => UrlLauncherUtils.launchUrl('https://www.linkedin.com/in/namit-solanki/'),
        ).animate().fadeIn(duration: 600.ms, delay: 1100.ms).slideX(begin: 0.2, end: 0),
      ],
    );
  }
}
