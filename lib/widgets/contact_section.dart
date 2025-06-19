import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'premium_glassmorphic_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final contactMethods = [
      {
        'title': 'Email',
        'subtitle': 'namitsolanki48@gmail.com',
        'icon': Icons.email_outlined,
        'url': 'mailto:namitsolanki48@gmail.com',
        'color': const Color(0xFFEF4444),
      },
      {
        'title': 'GitHub',
        'subtitle': 'github.com/Namit24',
        'icon': Icons.code,
        'url': 'https://github.com/Namit24',
        'color': const Color(0xFF374151),
      },
      {
        'title': 'LinkedIn',
        'subtitle': 'linkedin.com/in/namit-solanki',
        'icon': Icons.business,
        'url': 'https://linkedin.com/in/namit-solanki',
        'color': const Color(0xFF0EA5E9),
      },
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 1.5,
          colors: [
            const Color(0xFF06B6D4).withOpacity(0.05),
            const Color(0xFF3B82F6).withOpacity(0.03),
            Colors.transparent,
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 100, 24, 24), // FIXED: Top padding for app bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER SECTION
            PremiumGlassmorphicCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.contact_mail_outlined,
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
                          'Get In Touch',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4), // ORGANIZED: Small spacing
                        Text(
                          'Let\'s connect and collaborate',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 24), // ORGANIZED: Section spacing

            // CONTACT METHODS
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contactMethods.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16), // ORGANIZED: Consistent spacing
              itemBuilder: (context, index) {
                final contact = contactMethods[index];
                return _buildContactCard(context, contact, index);
              },
            ),

            const SizedBox(height: 24), // ORGANIZED: Section spacing

            // CALL TO ACTION
            PremiumGlassmorphicCard(
              isHoverable: true,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.handshake_outlined,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20), // ORGANIZED: Content spacing
                  Text(
                    'Let\'s Build Something Amazing Together!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12), // ORGANIZED: Content spacing
                  Text(
                    'I\'m always excited to work on innovative projects and collaborate with talented individuals.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).animate().slideY(
              begin: 0.3,
              delay: 800.ms,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),

            const SizedBox(height: 40), // ORGANIZED: Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, Map<String, dynamic> contact, int index) {
    return PremiumGlassmorphicCard(
      isHoverable: true,
      onTap: () => _launchUrl(contact['url'] as String),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (contact['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (contact['color'] as Color).withOpacity(0.3),
              ),
            ),
            child: Icon(
              contact['icon'] as IconData,
              color: contact['color'] as Color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16), // ORGANIZED: Consistent spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['title'] as String,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), // ORGANIZED: Small spacing
                Text(
                  contact['subtitle'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (contact['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: contact['color'] as Color,
            ),
          ),
        ],
      ),
    ).animate(delay: Duration(milliseconds: 200 + index * 100)).slideX(
      begin: 0.3,
      duration: 600.ms,
      curve: Curves.easeOutCubic,
    ).fadeIn(duration: 400.ms);
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
