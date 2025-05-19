import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final IconData icon;
  final String url;
  final List<String> technologies;

  const Project({
    required this.title,
    required this.description,
    required this.icon,
    required this.url,
    required this.technologies,
  });
}
