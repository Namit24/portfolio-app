import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedSkillChip extends StatelessWidget {
  final String label;
  final int delay;
  final Color color;

  const AnimatedSkillChip({
    super.key,
    required this.label,
    required this.delay,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
      backgroundColor: color.withOpacity(0.7),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ).animate().fadeIn(duration: 600.ms, delay: delay.ms).scale(
      begin: const Offset(0.8, 0.8),
      end: const Offset(1, 1),
    );
  }
}
