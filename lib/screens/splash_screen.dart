import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_app/screens/home_page.dart';
import 'package:portfolio_app/theme/app_colors.dart';
import 'package:portfolio_app/utils/navigation_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _animationLoaded = false;
  bool _animationError = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigateToHome();
      }
    });

    // Auto-navigate after 1 second even if animation fails
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!_animationLoaded && mounted) {
        setState(() {
          _animationError = true;
        });
      }
    });
  }

  void navigateToHome() {
    if (!mounted) return;

    NavigationUtils.pushReplacementWithSlideTransition(
      context,
      const HomePage(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_animationError)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 250,
                          width: 250,
                          child: Lottie.asset(
                            'assets/animations/coding_animation.json',
                            controller: _controller,
                            fit: BoxFit.contain,
                            onLoaded: (composition) {
                              setState(() {
                                _animationLoaded = true;
                              });
                              // Set a shorter duration and speed up the animation
                              _controller.duration = const Duration(milliseconds: 1000);
                              _controller.forward();
                            },
                            errorBuilder: (context, error, stackTrace) {
                              setState(() {
                                _animationError = true;
                              });
                              return _buildFallbackAnimation();
                            },
                          ),
                        ),
                      )
                    else
                      _buildFallbackAnimation(),
                    const SizedBox(height: 30),
                    Text(
                      'Namit Solanki',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.teal,
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.3, end: 0),
                    const SizedBox(height: 10),
                    Text(
                      'Developer & Data Scientist',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.darkGray,
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.3, end: 0),
                  ],
                ),
              ),
            ),
            // Skip button
            Positioned(
              top: 16,
              right: 16,
              child: TextButton.icon(
                onPressed: navigateToHome,
                icon: const Icon(Icons.skip_next),
                label: const Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.mint.withOpacity(0.3),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackAnimation() {
    // Fallback animation using built-in Flutter animations
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.mint.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.code,
          size: 80,
          color: AppColors.teal,
        ),
      ),
    ).animate(
      onPlay: (controller) => controller.repeat(),
    ).scale(
      duration: 1500.ms,
      begin: const Offset(0.8, 0.8),
      end: const Offset(1.1, 1.1),
    ).then().scale(
      duration: 1500.ms,
      begin: const Offset(1.1, 1.1),
      end: const Offset(0.8, 0.8),
    );
  }
}
