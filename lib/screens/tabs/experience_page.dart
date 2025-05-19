import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_app/theme/app_colors.dart';
import 'package:portfolio_app/widgets/experience_card.dart';
import 'package:portfolio_app/widgets/award_item.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ExperienceCard(
          title: 'DBMS & Data Science Intern',
          company: 'Nereus Technologies',
          location: 'Bengaluru, India',
          duration: 'March 2025 - April 2025',
          description: [
            'Developed a PostgreSQL database and backend system to handle real-time IMU sensor data (velocity, acceleration, joint angles, timestamps), implemented Bluetooth connectivity for real-time CSV generation, and designed an Admin dashboard for managing sessions, user data, and exercise configurations.',
            'Created a user dashboard for interactive exercise tracking and data visualization, featuring session management (examiner login, auto-generated session IDs, pre/post-session inputs) and lapping functionality for accurate real-time data segmentation and analysis.',
          ],
          animationDelay: 0,
        ),
        const SizedBox(height: 16),
        ExperienceCard(
          title: 'No Code ML Model Builder',
          company: 'Self-Employed',
          location: 'Pune, IN',
          duration: 'Sept. 2024 - Present',
          description: [
            'Developed a no-code machine learning model builder with Python scripts running on a Uvicorn server, enabling users to create ML models with just a click. Integrated scikit-learn for model creation, matplotlib for visualizations, and Streamlit for the frontend interface.',
            'Implemented automated data preprocessing features, including data cleaning, encoding, and transformation, ensuring seamless model building and deployment.',
          ],
          animationDelay: 200,
        ),
        const SizedBox(height: 16),
        _buildAwardsSection(context),
      ],
    );
  }

  Widget _buildAwardsSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Awards',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.teal,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            AwardItem(
              title: 'All India Rank 6 in TechXlerate Hackathon at BITS Pilani',
              date: 'Feb. 2025',
              description: 'Our team developed a platform where anyone can build their own ML models using a simple drag-and-drop technique without any coding required.',
              animationDelay: 300,
            ),
            const SizedBox(height: 12),
            AwardItem(
              title: 'Computer Science Subject Topper',
              date: 'Aug. 2023 - Present',
              description: 'Award given to the student securing highest marks in Computer Science in XII Boards.',
              animationDelay: 400,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, end: 0);
  }
}
