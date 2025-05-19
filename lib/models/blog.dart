import 'package:flutter/material.dart';

class Blog {
  final String title;
  final String description;
  final String url;
  final String date;
  final IconData icon;

  const Blog({
    required this.title,
    required this.description,
    required this.url,
    required this.date,
    required this.icon,
  });
}
