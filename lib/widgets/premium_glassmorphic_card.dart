import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:math' as math;

class PremiumGlassmorphicCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final double blur;
  final bool isHoverable;
  final VoidCallback? onTap;

  const PremiumGlassmorphicCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 24,
    this.backgroundColor,
    this.blur = 25,
    this.isHoverable = false,
    this.onTap,
  });

  @override
  State<PremiumGlassmorphicCard> createState() => _PremiumGlassmorphicCardState();
}

class _PremiumGlassmorphicCardState extends State<PremiumGlassmorphicCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _tapController;
  late AnimationController _glowController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _glowAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _tapController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _tapController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _tapController, _glowController]),
      builder: (context, child) {
        final tapScale = _tapController.isAnimating ? 0.98 : 1.0;

        return MouseRegion(
          onEnter: widget.isHoverable ? (_) {
            setState(() => _isHovered = true);
            _hoverController.forward();
          } : null,
          onExit: widget.isHoverable ? (_) {
            setState(() => _isHovered = false);
            _hoverController.reverse();
          } : null,
          child: GestureDetector(
            onTapDown: widget.isHoverable ? (_) {
              HapticFeedback.lightImpact();
              _tapController.forward();
            } : null,
            onTapUp: widget.isHoverable ? (_) => _tapController.reverse() : null,
            onTapCancel: widget.isHoverable ? () => _tapController.reverse() : null,
            onTap: widget.onTap,
            child: Transform.scale(
              scale: _scaleAnimation.value * tapScale,
              child: Container(
                width: widget.width,
                height: widget.height,
                margin: widget.margin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: [
                    // MAIN SHADOW
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.5)
                          : Colors.black.withOpacity(0.12),
                      blurRadius: 40 + _elevationAnimation.value,
                      offset: Offset(0, 20 + _elevationAnimation.value * 0.5),
                      spreadRadius: -10,
                    ),
                    // GLOW EFFECT
                    if (_isHovered || _glowAnimation.value > 0.5)
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(
                          _isHovered ? 0.3 : _glowAnimation.value * 0.1,
                        ),
                        blurRadius: 60 + _elevationAnimation.value,
                        offset: Offset(0, 30 + _elevationAnimation.value),
                        spreadRadius: -5,
                      ),
                    // INNER GLOW
                    BoxShadow(
                      color: Colors.white.withOpacity(
                        _isHovered ? 0.1 : 0.05,
                      ),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                      spreadRadius: -10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: widget.blur + (_isHovered ? 5 : 0),
                      sigmaY: widget.blur + (_isHovered ? 5 : 0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            widget.backgroundColor ??
                                (isDark
                                    ? Colors.white.withOpacity(_isHovered ? 0.12 : 0.08)
                                    : Colors.white.withOpacity(_isHovered ? 0.95 : 0.85)),
                            widget.backgroundColor ??
                                (isDark
                                    ? Colors.white.withOpacity(_isHovered ? 0.08 : 0.04)
                                    : Colors.white.withOpacity(_isHovered ? 0.85 : 0.75)),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(_isHovered ? 0.25 : 0.15)
                              : Colors.white.withOpacity(_isHovered ? 0.9 : 0.8),
                          width: _isHovered ? 2 : 1.5,
                        ),
                      ),
                      padding: widget.padding ?? const EdgeInsets.all(24),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
