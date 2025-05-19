import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_app/models/project.dart';
import 'package:portfolio_app/theme/app_colors.dart';
import 'package:portfolio_app/utils/url_launcher_utils.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          project.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: AppColors.mint.withOpacity(0.7),
              child: Center(
                child: Icon(
                  project.icon,
                  size: 100,
                  color: AppColors.teal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: AppColors.teal,
                      fontSize: 24,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 12),
                  Text(
                    project.description,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      height: 1.5,
                      fontSize: 16,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  const SizedBox(height: 24),
                  Text(
                    'Technologies Used',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: AppColors.teal,
                      fontSize: 18,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies.map((tech) {
                      return Chip(
                        label: Text(
                          tech,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        backgroundColor: AppColors.mint.withOpacity(0.7),
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      );
                    }).toList(),
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => UrlLauncherUtils.launchUrl(project.url, context: context),
                      icon: const Icon(Icons.code),
                      label: const Text(
                        'View Code on GitHub',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
