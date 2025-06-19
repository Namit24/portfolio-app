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
  late AnimationController _particleController;
  late AnimationController _gradientController;
  late ScrollController _scrollController;

  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();

    // FLOATING ANIMATION
    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    // PARTICLE ANIMATION
    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // GRADIENT ANIMATION
    _gradientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    // SCROLL CONTROLLER FOR PARALLAX
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _particleController.dispose();
    _gradientController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ANIMATED BACKGROUND WITH PARTICLES
        _buildAnimatedBackground(),

        // MAIN CONTENT WITH PARALLAX
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.8,
              colors: [
                const Color(0xFF6366F1).withOpacity(0.08),
                const Color(0xFF8B5CF6).withOpacity(0.05),
                Colors.transparent,
              ],
            ),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // HERO PROFILE CARD WITH CRAZY ANIMATIONS
                _buildHeroProfileCard(),

                const SizedBox(height: 32),

                // FLOATING STATS CARDS
                _buildFloatingStatsCards(),

                const SizedBox(height: 32),

                // MORPHING ABOUT CARD
                _buildMorphingAboutCard(),

                const SizedBox(height: 32),

                // INTERACTIVE SKILL BUBBLES
                _buildInteractiveSkillBubbles(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlesPainter(_particleController.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildHeroProfileCard() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final floatValue = math.sin(_floatingController.value * 2 * math.pi) * 10;

        return Transform.translate(
          offset: Offset(0, floatValue - _scrollOffset * 0.3), // PARALLAX EFFECT
          child: PremiumGlassmorphicCard(
            isHoverable: true,
            child: Column(
              children: [
                // PROFILE IMAGE WITH MORPHING BORDER
                AnimatedBuilder(
                  animation: _gradientController,
                  builder: (context, child) {
                    return Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35 + math.sin(_gradientController.value * 2 * math.pi) * 5),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.lerp(const Color(0xFF6366F1), const Color(0xFF8B5CF6), _gradientController.value)!,
                            Color.lerp(const Color(0xFF8B5CF6), const Color(0xFF06B6D4), _gradientController.value)!,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withOpacity(0.4),
                            blurRadius: 50 + math.sin(_gradientController.value * 2 * math.pi) * 10,
                            offset: Offset(0, 25 + floatValue),
                            spreadRadius: -15,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35 + math.sin(_gradientController.value * 2 * math.pi) * 5),
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.lerp(const Color(0xFF6366F1), const Color(0xFF8B5CF6), _gradientController.value)!,
                                    Color.lerp(const Color(0xFF8B5CF6), const Color(0xFF06B6D4), _gradientController.value)!,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(35),
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
                    );
                  },
                ).animate().scale(
                  delay: 200.ms,
                  duration: 1200.ms,
                  curve: Curves.elasticOut,
                ).shimmer(
                  delay: 2000.ms,
                  duration: 3000.ms,
                  color: Colors.white.withOpacity(0.5),
                ),

                const SizedBox(height: 32),

                // TYPEWRITER EFFECT NAME
                _buildTypewriterText(
                  'Namit Solanki',
                  Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 12),

                // MORPHING TITLE CONTAINER
                AnimatedBuilder(
                  animation: _gradientController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.lerp(const Color(0xFF6366F1), const Color(0xFF8B5CF6), _gradientController.value)!,
                            Color.lerp(const Color(0xFF8B5CF6), const Color(0xFF06B6D4), _gradientController.value)!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30 + math.sin(_gradientController.value * 4 * math.pi) * 5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withOpacity(0.4),
                            blurRadius: 25 + math.sin(_gradientController.value * 2 * math.pi) * 5,
                            offset: const Offset(0, 12),
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
                    );
                  },
                ).animate().scale(
                  delay: 600.ms,
                  duration: 800.ms,
                  curve: Curves.easeOutBack,
                ).then().shimmer(
                  duration: 2000.ms,
                  color: Colors.white.withOpacity(0.3),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingStatsCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFloatingStatCard('10+', 'Projects', 0, Icons.work_outline),
        _buildFloatingStatCard('2+', 'Experience', 1, Icons.timeline),
        _buildFloatingStatCard('15+', 'Skills', 2, Icons.code),
      ],
    );
  }

  Widget _buildFloatingStatCard(String number, String label, int index, IconData icon) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final floatValue = math.sin((_floatingController.value + index * 0.3) * 2 * math.pi) * 8;

        return Transform.translate(
          offset: Offset(0, floatValue - _scrollOffset * 0.2),
          child: PremiumGlassmorphicCard(
            isHoverable: true,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _gradientController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.lerp(const Color(0xFF6366F1), const Color(0xFF8B5CF6), (_gradientController.value + index * 0.3) % 1)!,
                            Color.lerp(const Color(0xFF8B5CF6), const Color(0xFF06B6D4), (_gradientController.value + index * 0.3) % 1)!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withOpacity(0.3),
                            blurRadius: 15,
                            offset: Offset(0, 5 + floatValue * 0.5),
                          ),
                        ],
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 24,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 2000 + (index * 300)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          const Color(0xFF6366F1).withOpacity(value),
                          const Color(0xFF8B5CF6).withOpacity(value),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        number,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ).animate(delay: Duration(milliseconds: 800 + index * 200)).slideY(
            begin: 50,
            duration: 800.ms,
            curve: Curves.easeOutBack,
          ).fadeIn(duration: 600.ms),
        );
      },
    );
  }

  Widget _buildMorphingAboutCard() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final floatValue = math.sin(_floatingController.value * 2 * math.pi) * 5;

        return Transform.translate(
          offset: Offset(0, floatValue - _scrollOffset * 0.1),
          child: PremiumGlassmorphicCard(
            isHoverable: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AnimatedBuilder(
                      animation: _gradientController,
                      builder: (context, child) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.lerp(const Color(0xFF06B6D4), const Color(0xFF0EA5E9), _gradientController.value)!,
                                Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF06B6D4), _gradientController.value)!,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16 + math.sin(_gradientController.value * 4 * math.pi) * 3),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF06B6D4).withOpacity(0.4),
                                blurRadius: 25 + math.sin(_gradientController.value * 2 * math.pi) * 5,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 28,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About Me',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().slideX(
                            delay: 1200.ms,
                            duration: 600.ms,
                            begin: -50,
                            curve: Curves.easeOutCubic,
                          ),
                          Text(
                            'Passionate Developer',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ).animate().slideX(
                            delay: 1400.ms,
                            duration: 600.ms,
                            begin: -30,
                            curve: Curves.easeOutCubic,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'I\'m a dedicated App & ML Developer with a passion for creating innovative solutions that bridge the gap between cutting-edge technology and user-friendly experiences.\n\n'
                      'My journey in technology has led me to contribute to open-source projects like Scikit-Learn and develop cutting-edge applications in machine learning and mobile development.\n\n'
                      'I believe in the power of technology to solve real-world problems and am constantly exploring new ways to push the boundaries of what\'s possible.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.7,
                  ),
                ).animate().slideY(
                  delay: 1600.ms,
                  duration: 800.ms,
                  begin: 30,
                  curve: Curves.easeOutCubic,
                ).fadeIn(delay: 1600.ms, duration: 800.ms),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInteractiveSkillBubbles() {
    final skills = [
      {'name': 'Flutter', 'color': const Color(0xFF02569B)},
      {'name': 'Python', 'color': const Color(0xFF3776AB)},
      {'name': 'ML/AI', 'color': const Color(0xFF10B981)},
      {'name': 'Firebase', 'color': const Color(0xFFFFCA28)},
      {'name': 'Kotlin', 'color': const Color(0xFF7F52FF)},
      {'name': 'Git', 'color': const Color(0xFFF05032)},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: skills.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;

        return AnimatedBuilder(
          animation: _floatingController,
          builder: (context, child) {
            final floatValue = math.sin((_floatingController.value + index * 0.2) * 2 * math.pi) * 6;

            return Transform.translate(
              offset: Offset(0, floatValue),
              child: GestureDetector(
                onTap: () {
                  // Add haptic feedback or sound here
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        skill['color'] as Color,
                        (skill['color'] as Color).withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: (skill['color'] as Color).withOpacity(0.3),
                        blurRadius: 15 + math.sin((_floatingController.value + index * 0.2) * 2 * math.pi) * 3,
                        offset: Offset(0, 5 + floatValue * 0.3),
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
              ).animate(delay: Duration(milliseconds: 2000 + index * 100)).scale(
                begin: const Offset(0.5, 0.5),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              ).fadeIn(duration: 400.ms),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildTypewriterText(String text, TextStyle? style) {
    return TweenAnimationBuilder<int>(
      duration: Duration(milliseconds: text.length * 100),
      tween: IntTween(begin: 0, end: text.length),
      builder: (context, value, child) {
        return ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          ).createShader(bounds),
          child: Text(
            text.substring(0, value),
            style: style?.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }
}

// CUSTOM PAINTER FOR PARTICLE EFFECTS
class ParticlesPainter extends CustomPainter {
  final double animationValue;

  ParticlesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final x = (size.width * (i / 20) + animationValue * 100) % size.width;
      final y = (size.height * math.sin(animationValue * 2 * math.pi + i) * 0.1 + size.height * 0.5) % size.height;
      final radius = 2 + math.sin(animationValue * 4 * math.pi + i) * 1;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
