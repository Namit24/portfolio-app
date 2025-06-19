import 'package:flutter/material.dart';
import 'dart:ui';

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
    this.blur = 20,
    this.isHoverable = false,
    this.onTap,
  });

  @override
  State<PremiumGlassmorphicCard> createState() => _PremiumGlassmorphicCardState();
}

class _PremiumGlassmorphicCardState extends State<PremiumGlassmorphicCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: widget.isHoverable ? (_) => _controller.forward() : null,
            onTapUp: widget.isHoverable ? (_) => _controller.reverse() : null,
            onTapCancel: widget.isHoverable ? () => _controller.reverse() : null,
            onTap: widget.onTap,
            child: Container(
              width: widget.width,
              height: widget.height,
              margin: widget.margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: isDark 
                        ? Colors.black.withOpacity(0.4)
                        : Colors.black.withOpacity(0.08),
                    blurRadius: 32 + _elevationAnimation.value,
                    offset: Offset(0, 16 + _elevationAnimation.value),
                    spreadRadius: -8,
                  ),
                  BoxShadow(
                    color: isDark 
                        ? Colors.black.withOpacity(0.2)
                        : Colors.black.withOpacity(0.04),
                    blurRadius: 16 + _elevationAnimation.value,
                    offset: Offset(0, 8 + _elevationAnimation.value),
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? 
                             (isDark 
                                 ? Colors.white.withOpacity(0.05)
                                 : Colors.white.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      border: Border.all(
                        color: isDark 
                            ? Colors.white.withOpacity(0.1)
                            : Colors.white.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                    padding: widget.padding ?? const EdgeInsets.all(24),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
