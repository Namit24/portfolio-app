import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/ultra_modern_about_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/extracurricular_section.dart';
import '../widgets/contact_section.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _navAnimationController;
  late AnimationController _appBarController;

  final List<Widget> _sections = [
    const UltraModernAboutSection(),
    const ProjectsSection(),
    const ExperienceSection(),
    const ExtracurricularSection(),
    const ContactSection(),
  ];

  final List<String> _sectionTitles = [
    'About Me',
    'Projects',
    'Experience',
    'Extracurricular',
    'Contact',
  ];

  final List<IconData> _sectionIcons = [
    Icons.person_outline,
    Icons.work_outline,
    Icons.business_center_outlined,
    Icons.groups_outlined,
    Icons.contact_mail_outlined,
  ];

  @override
  void initState() {
    super.initState();
    _navAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _appBarController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _navAnimationController.dispose();
    _appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // MORPHING APP BAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedBuilder(
          animation: _appBarController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(
                      Colors.white.withOpacity(0.1),
                      Colors.purple.withOpacity(0.1),
                      _appBarController.value,
                    )!,
                    Color.lerp(
                      Colors.white.withOpacity(0.05),
                      Colors.blue.withOpacity(0.05),
                      _appBarController.value,
                    )!,
                  ],
                ),
              ),
              child: AppBar(
                title: Text(_sectionTitles[_currentIndex]).animate().slideX(
                  duration: 300.ms,
                  curve: Curves.easeOutCubic,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6366F1).withOpacity(0.8),
                          const Color(0xFF8B5CF6).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Theme.of(context).brightness == Brightness.dark
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        widget.onThemeToggle();
                      },
                    ),
                  ).animate().scale(
                    duration: 200.ms,
                    curve: Curves.easeOutBack,
                  ).shimmer(
                    delay: 2000.ms,
                    duration: 2000.ms,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      // ADVANCED PAGE VIEW WITH CUSTOM TRANSITIONS
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          HapticFeedback.selectionClick();
          _navAnimationController.forward().then((_) {
            _navAnimationController.reverse();
          });
        },
        physics: const BouncingScrollPhysics(),
        itemCount: _sections.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }

              return Transform.scale(
                scale: Curves.easeOut.transform(value),
                child: Opacity(
                  opacity: value,
                  child: _sections[index],
                ),
              );
            },
          );
        },
      ),

      // FLOATING NAVIGATION BAR WITH MORPHING EFFECTS
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 15),
              spreadRadius: -5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: AnimatedBuilder(
            animation: _navAnimationController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.surface.withOpacity(0.95),
                      Theme.of(context).colorScheme.surface.withOpacity(0.9),
                    ],
                  ),
                ),
                child: NavigationBar(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    HapticFeedback.mediumImpact();
                    setState(() {
                      _currentIndex = index;
                    });

                    // SMOOTH PAGE TRANSITION WITH CUSTOM CURVE
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  destinations: List.generate(_sectionTitles.length, (index) {
                    final isSelected = _currentIndex == index;

                    return NavigationDestination(
                      icon: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.all(isSelected ? 12 : 8),
                        decoration: BoxDecoration(
                          gradient: isSelected ? const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ) : null,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: const Color(0xFF6366F1).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ] : null,
                        ),
                        child: Icon(
                          _sectionIcons[index],
                          color: isSelected ? Colors.white : null,
                          size: isSelected ? 24 : 20,
                        ),
                      ).animate(target: isSelected ? 1 : 0).scale(
                        duration: 300.ms,
                        curve: Curves.easeOutBack,
                      ),
                      selectedIcon: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6366F1).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          _sectionIcons[index],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      label: _sectionTitles[index],
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ).animate().slideY(
        begin: 100,
        duration: 800.ms,
        delay: 500.ms,
        curve: Curves.easeOutBack,
      ).fadeIn(duration: 600.ms, delay: 500.ms),
    );
  }
}
