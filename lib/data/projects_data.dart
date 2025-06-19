import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectsData {
  static final List<Project> projects = [
    Project(
      title: 'No Code ML Model Builder',
      role: 'Self-Employed Developer',
      description: 'Developed a comprehensive platform that allows users to build and deploy machine learning models without writing code. Features drag-and-drop interface, automated data preprocessing, and model deployment capabilities.',
      technologies: ['Python', 'Flask', 'TensorFlow', 'React', 'Docker'],
      icon: Icons.psychology,
    ),
    Project(
      title: 'Anti-Cheating Extension',
      role: 'Self-Employed Developer',
      description: 'Created a browser extension to detect and prevent cheating in online examinations. Implements advanced monitoring techniques and real-time analysis to ensure exam integrity.',
      technologies: ['JavaScript', 'Chrome Extension API', 'WebRTC', 'Python'],
      icon: Icons.security,
    ),
    Project(
      title: 'Scikit-Learn Contributions',
      role: 'Open Source Contributor',
      description: 'Active contributor to the Scikit-Learn machine learning library. Contributed to algorithm improvements, bug fixes, and documentation enhancements.',
      technologies: ['Python', 'NumPy', 'SciPy', 'Machine Learning'],
      icon: Icons.code,
    ),
    Project(
      title: 'Mobile App Portfolio',
      role: 'Flutter Developer',
      description: 'Developed multiple cross-platform mobile applications using Flutter, focusing on user experience and performance optimization.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
      icon: Icons.phone_android,
    ),
  ];
}
