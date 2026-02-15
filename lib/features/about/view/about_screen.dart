import 'package:flutter/material.dart';

import 'package:portfolio/core/widgets/portfolio_state_builder.dart';
import 'package:portfolio/core/widgets/responsive_body.dart';
import 'package:portfolio/utils/context_l10n.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/utils/url.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PortfolioStateBuilder(
      title: l10n.aboutTitle,
      builder: (context, data) {
        final about = data.about;
        final contact = data.contact;
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          appBar: AppBar(title: Text(l10n.aboutTitle)),
          body: ResponsiveBody(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Avatar (photo ou initiales) ──
                  Center(
                    child: about.photo.isNotEmpty
                        ? CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage(about.photo),
                    )
                        : CircleAvatar(
                      radius: 52,
                      backgroundColor: colorScheme.primaryContainer,
                      child: Text(
                        about.initials.isNotEmpty
                            ? about.initials
                            : 'PM',
                        style:
                        theme.textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Nom ──
                  Center(
                    child: Text(
                      about.name.isNotEmpty ? about.name : l10n.appTitle,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      data.hero.tagline.isNotEmpty
                          ? data.hero.tagline
                          : l10n.tagline,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Infos clés (dynamiques) ──
                  if (about.experience.isNotEmpty)
                    _InfoRow(
                      icon: Icons.work_history,
                      label: l10n.availability,
                      value: about.experience,
                    ),
                  if (about.location.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: l10n.mobility,
                      value: about.location,
                    ),
                  ],
                  if (about.stack.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.code,
                      label: 'Stack',
                      value: about.stack,
                    ),
                  ],
                  const SizedBox(height: 24),

                  // ── Paragraphe "À propos" ──
                  Text(
                    l10n.aboutTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    about.paragraph.isNotEmpty
                        ? about.paragraph
                        : l10n.aboutParagraph,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // ── Liens ──
                  if (contact.linkedin.isNotEmpty ||
                      contact.github.isNotEmpty ||
                      contact.email.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (contact.linkedin.isNotEmpty)
                          ActionChip(
                            avatar: const Icon(Icons.business, size: 18),
                            label: const Text('LinkedIn'),
                            onPressed: () =>
                                launchExternal(contact.linkedin),
                          ),
                        if (contact.github.isNotEmpty)
                          ActionChip(
                            avatar: const Icon(Icons.code, size: 18),
                            label: const Text('GitHub'),
                            onPressed: () =>
                                launchExternal(contact.github),
                          ),
                        if (contact.email.isNotEmpty)
                          ActionChip(
                            avatar: const Icon(Icons.email, size: 18),
                            label: Text(contact.email),
                            onPressed: () => launchExternal(
                                'mailto:${contact.email}'),
                          ),
                      ],
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '$label : ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}