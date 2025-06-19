import 'package:flutter/material.dart';

class Project {
  final String title;
  final String role;
  final String description;
  final List<String> technologies;
  final IconData icon;

  Project({
    required this.title,
    required this.role,
    required this.description,
    required this.technologies,
    required this.icon,
  });
}
