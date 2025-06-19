import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const SplashScreen({super.key, required this.onThemeToggle});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _fadeController;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.forward();
    
    await Future.delayed(const Duration(milliseconds: 3000));
    _fadeController.forward();
    
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
              HomeScreen(onThemeToggle: widget.onThemeToggle),
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: AnimatedBuilder(
        animation: _fadeController,
        builder: (context, child) {
          return Opacity(
            opacity: 1.0 - _fadeController.value,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF8FAFC),
                    Color(0xFFE2E8F0),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  width: 320,
                  height: 500,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Stack(
                    children: [
                      // Main Card
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 40,
                                offset: const Offset(0, 20),
                                spreadRadius: -5,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 80,
                                offset: const Offset(0, 40),
                                spreadRadius: -10,
                              ),
                            ],
                          ),
                        ).animate().scale(
                          delay: 200.ms,
                          duration: 1200.ms,
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.0, 1.0),
                          curve: Curves.easeOutCubic,
                        ).fadeIn(
                          delay: 200.ms,
                          duration: 800.ms,
                        ),
                      ),
                      
                      // Content
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              
                              // Profile Image
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.2),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: ColorFiltered(
                                    colorFilter: const ColorFilter.matrix([
                                      0.2126, 0.7152, 0.0722, 0, 0,
                                      0.2126, 0.7152, 0.0722, 0, 0,
                                      0.2126, 0.7152, 0.0722, 0, 0,
                                      0, 0, 0, 1, 0,
                                    ]),
                                    child: Image.asset(
                                      'assets/images/profile.jpg',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Color(0xFF64748B), Color(0xFF475569)],
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'NS',
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ).animate().scale(
                                delay: 800.ms,
                                duration: 1000.ms,
                                begin: const Offset(0.5, 0.5),
                                end: const Offset(1.0, 1.0),
                                curve: Curves.elasticOut,
                              ).fadeIn(
                                delay: 600.ms,
                                duration: 800.ms,
                              ),
                              
                              const SizedBox(height: 32),
                              
                              // Name
                              Text(
                                'Namit Solanki',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                ),
                                textAlign: TextAlign.center,
                              ).animate().slideY(
                                delay: 1000.ms,
                                duration: 800.ms,
                                begin: 30,
                                end: 0,
                                curve: Curves.easeOutCubic,
                              ).fadeIn(
                                delay: 1000.ms,
                                duration: 600.ms,
                              ),
                              
                              const SizedBox(height: 8),
                              
                              // Title
                              Text(
                                'App & ML Developer',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF94A3B8),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ).animate().slideY(
                                delay: 1200.ms,
                                duration: 800.ms,
                                begin: 30,
                                end: 0,
                                curve: Curves.easeOutCubic,
                              ).fadeIn(
                                delay: 1200.ms,
                                duration: 600.ms,
                              ),
                              
                              const SizedBox(height: 32),
                              
                              // Description
                              Text(
                                'Namit Solanki is a proficient developer specializing in application and machine learning development. With a robust background in software engineering, he has a knack for creating innovative solutions and optimizing machine learning algorithms for enhanced performance.',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF64748B),
                                  height: 1.6,
                                  letterSpacing: 0.2,
                                ),
                                textAlign: TextAlign.center,
                              ).animate().slideY(
                                delay: 1400.ms,
                                duration: 800.ms,
                                begin: 30,
                                end: 0,
                                curve: Curves.easeOutCubic,
                              ).fadeIn(
                                delay: 1400.ms,
                                duration: 600.ms,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
