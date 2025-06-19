import 'package:flutter/material.dart';
import '../models/experience.dart';

class ExperienceData {
  static final List<Experience> experiences = [
    Experience(
      position: 'Contributor',
      company: 'Scikit-Learn',
      duration: '2023 - Present',
      description: 'Contributing to one of the most popular machine learning libraries in Python, focusing on algorithm improvements and documentation.',
      achievements: [
        'Contributed to core machine learning algorithms',
        'Improved documentation and examples',
        'Participated in code reviews and community discussions',
      ],
      icon: Icons.code,
    ),
    Experience(
      position: 'DBMS & Data Science Intern',
      company: 'Nereus Technologies',
      duration: '2023',
      description: 'Worked on database management systems and data science projects, gaining hands-on experience with large-scale data processing.',
      achievements: [
        'Optimized database queries for better performance',
        'Developed data analysis pipelines',
        'Created data visualization dashboards',
      ],
      icon: Icons.storage,
    ),
  ];
}
