import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'premium_glassmorphic_card.dart';
import 'dart:math' as math;

class UltraModernAboutSection extends StatefulWidget {
  const UltraModernAboutSection({super.key});

  @override
  State<UltraModernAboutSection> createState() => _UltraModernAboutSectionState();
}

class _UltraModernAboutSectionState extends State<UltraModernAboutSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late ScrollController _scrollController;

  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _scrollController = ScrollController()
      ..addListener(() {
        if (mounted) {
          setState(() {
            _scrollOffset = _scrollController.offset;
          });
        }
      });
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.8,
            colors: [
              Color(0x146366F1),
              Color(0x0D8B5CF6),
              Colors.transparent,
            ],
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.fromLTRB(24, 100, 24, 24), // FIXED: Top padding for app bar
          child: Column(
            children: [
              // HERO PROFILE SECTION
              _buildHeroProfileCard(),

              const SizedBox(height: 24), // ORGANIZED: Consistent spacing

              // STATS SECTION
              _buildStatsSection(),

              const SizedBox(height: 24), // ORGANIZED: Consistent spacing

              // ABOUT SECTION
              _buildAboutSection(),

              const SizedBox(height: 24), // ORGANIZED: Consistent spacing

              // SKILLS SECTION
              _buildSkillsSection(),

              const SizedBox(height: 40), // ORGANIZED: Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroProfileCard() {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _floatingController,
        builder: (context, child) {
          final floatValue = math.sin(_floatingController.value * 2 * math.pi) * 4;

          return Transform.translate(
            offset: Offset(0, floatValue),
            child: PremiumGlassmorphicCard(
              isHoverable: true,
              child: Column(
                children: [
                  // Profile Image
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 30,
                          offset: Offset(0, 15 + floatValue * 0.5),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'NS',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ).animate().scale(
                    delay: 300.ms,
                    duration: 1000.ms,
                    curve: Curves.easeOutCubic,
                  ),

                  const SizedBox(height: 24), // ORGANIZED: Proper spacing

                  // Name
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    ).createShader(bounds),
                    child: Text(
                      'Namit Solanki',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ).animate().slideY(
                    delay: 600.ms,
                    duration: 800.ms,
                    begin: 20,
                    curve: Curves.easeOutCubic,
                  ).fadeIn(delay: 600.ms, duration: 600.ms),

                  const SizedBox(height: 16), // ORGANIZED: Proper spacing

                  // Title
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      'App & ML Developer',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ).animate().scale(
                    delay: 900.ms,
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsSection() {
    return RepaintBoundary(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatCard('10+', 'Projects', Icons.work_outline, 0),
          _buildStatCard('2+', 'Experience', Icons.timeline, 1),
          _buildStatCard('15+', 'Skills', Icons.code, 2),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label, IconData icon, int index) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final floatValue = math.sin((_floatingController.value + index * 0.2) * 2 * math.pi) * 3;

        return Transform.translate(
          offset: Offset(0, floatValue),
          child: PremiumGlassmorphicCard(
            isHoverable: true,
            padding: const EdgeInsets.all(16), // ORGANIZED: Consistent padding
            width: 100,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6366F1 + (index * 0x001100)),
                        Color(0xFF8B5CF6 + (index * 0x000011)),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 4 + floatValue * 0.3),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8), // ORGANIZED: Consistent spacing
                Text(
                  number,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(height: 4), // ORGANIZED: Consistent spacing
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ).animate(delay: Duration(milliseconds: 1200 + index * 200)).slideY(
            begin: 30,
            duration: 600.ms,
            curve: Curves.easeOutCubic,
          ).fadeIn(duration: 400.ms),
        );
      },
    );
  }

  Widget _buildAboutSection() {
    return RepaintBoundary(
      child: PremiumGlassmorphicCard(
        isHoverable: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF06B6D4), Color(0xFF0EA5E9)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF06B6D4).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16), // ORGANIZED: Consistent spacing
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Me',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4), // ORGANIZED: Small spacing
                      Text(
                        'Passionate Developer',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // ORGANIZED: Section spacing

            // Content
            Text(
              'I\'m a dedicated App & ML Developer with a passion for creating innovative solutions that bridge the gap between cutting-edge technology and user-friendly experiences.\n\n'
                  'My journey in technology has led me to contribute to open-source projects like Scikit-Learn and develop cutting-edge applications in machine learning and mobile development.\n\n'
                  'I believe in the power of technology to solve real-world problems and am constantly exploring new ways to push the boundaries of what\'s possible.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
            ),
          ],
        ),
      ).animate().slideY(
        delay: 1800.ms,
        duration: 800.ms,
        begin: 40,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  Widget _buildSkillsSection() {
    const skills = [
      {'name': 'Flutter', 'color': Color(0xFF02569B)},
      {'name': 'Python', 'color': Color(0xFF3776AB)},
      {'name': 'ML/AI', 'color': Color(0xFF10B981)},
      {'name': 'Firebase', 'color': Color(0xFFFFCA28)},
      {'name': 'Kotlin', 'color': Color(0xFF7F52FF)},
      {'name': 'Git', 'color': Color(0xFFF05032)},
    ];

    return RepaintBoundary(
      child: Column(
        children: [
          // Skills Header
          Text(
            'Skills & Technologies',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6366F1),
            ),
          ).animate().fadeIn(delay: 2000.ms, duration: 600.ms),

          const SizedBox(height: 16), // ORGANIZED: Header spacing

          // Skills Grid
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: skills.asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;

              return AnimatedBuilder(
                animation: _floatingController,
                builder: (context, child) {
                  final floatValue = math.sin((_floatingController.value + index * 0.15) * 2 * math.pi) * 2;

                  return Transform.translate(
                    offset: Offset(0, floatValue),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: skill['color'] as Color,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: (skill['color'] as Color).withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 3 + floatValue * 0.5),
                          ),
                        ],
                      ),
                      child: Text(
                        skill['name'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate(delay: Duration(milliseconds: 2200 + index * 100)).scale(
                    begin: const Offset(0.8, 0.8),
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  ).fadeIn(duration: 300.ms);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
