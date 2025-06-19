import 'package:flutter/material.dart';

class Experience {
  final String position;
  final String company;
  final String duration;
  final String description;
  final List<String> achievements;
  final IconData icon;

  Experience({
    required this.position,
    required this.company,
    required this.duration,
    required this.description,
    required this.achievements,
    required this.icon,
  });
}
