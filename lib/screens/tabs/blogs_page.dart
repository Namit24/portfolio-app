import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_app/models/blog.dart';
import 'package:portfolio_app/theme/app_colors.dart';
import 'package:portfolio_app/utils/url_launcher_utils.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  final List<Blog> _blogs = const [
    Blog(
      title: 'Research Paper Collection',
      description: 'A collection of research papers and academic work.',
      url: 'https://drive.google.com/drive/u/1/folders/1_UgltTS478MFtPz3VDgE3sybrz1VdBJr',
      date: 'Various Dates',
      icon: Icons.article,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _blogs.length,
      itemBuilder: (context, index) {
        final blog = _blogs[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => UrlLauncherUtils.launchUrl(blog.url, context: context),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.yellow.withOpacity(0.7),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Icon(
                      blog.icon,
                      size: 80,
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
                        blog.title,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: AppColors.teal,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: AppColors.darkGray,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            blog.date,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.darkGray,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        blog.description,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          height: 1.5,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => UrlLauncherUtils.launchUrl(blog.url, context: context),
                            icon: const Icon(Icons.open_in_new),
                            label: const Text(
                              'Open Collection',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.teal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0);
      },
    );
  }
}
