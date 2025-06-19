import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'premium_glassmorphic_card.dart';

class UltraModernAboutSection extends StatelessWidget {
  const UltraModernAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [
            const Color(0xFF6366F1).withOpacity(0.05),
            const Color(0xFF8B5CF6).withOpacity(0.03),
            Colors.transparent,
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Hero Profile Card
            PremiumGlassmorphicCard(
              isHoverable: true,
              child: Column(
                children: [
                  // Profile Image with Floating Effect
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                          spreadRadius: -10,
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
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
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
                  ).animate().scale(
                    delay: 300.ms,
                    duration: 1200.ms,
                    curve: Curves.elasticOut,
                  ).shimmer(
                    delay: 1500.ms,
                    duration: 2000.ms,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Name with Gradient Text Effect
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
                    begin: 30,
                    curve: Curves.easeOutCubic,
                  ).fadeIn(delay: 600.ms),
                  
                  const SizedBox(height: 12),
                  
                  // Title with Animated Container
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
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
                    delay: 800.ms,
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Animated Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAnimatedStat(context, '10+', 'Projects', 0),
                      _buildStatDivider(context),
                      _buildAnimatedStat(context, '2+', 'Experience', 1),
                      _buildStatDivider(context),
                      _buildAnimatedStat(context, '15+', 'Skills', 2),
                    ],
                  ).animate().slideY(
                    delay: 1000.ms,
                    duration: 800.ms,
                    begin: 40,
                    curve: Curves.easeOutCubic,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // About Description with Floating Animation
            PremiumGlassmorphicCard(
              isHoverable: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 28,
                        ),
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
                            ),
                            Text(
                              'Passionate Developer',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF64748B),
                              ),
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
                      color: const Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ).animate().slideY(
              delay: 1200.ms,
              duration: 800.ms,
              begin: 50,
              curve: Curves.easeOutCubic,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedStat(BuildContext context, String number, String label, int index) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 1500 + (index * 200)),
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
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider(BuildContext context) {
    return Container(
      width: 1,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFFE2E8F0).withOpacity(0.5),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
