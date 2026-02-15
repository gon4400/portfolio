import 'package:flutter/material.dart';

import 'package:portfolio/core/widgets/portfolio_state_builder.dart';
import 'package:portfolio/core/widgets/responsive_body.dart';
import 'package:portfolio/utils/context_l10n.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/utils/url.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PortfolioStateBuilder(
      title: l10n.navContact,
      builder: (context, data) {
        final contact = data.contact;

        return Scaffold(
          appBar: AppBar(title: Text(l10n.navContact)),
          body: ResponsiveBody(
            child: ListView(
              padding: EdgeInsets.all(context.horizontalPadding),
              children: [
                Text(
                  l10n.contactIntro,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                if (contact.calendly.isNotEmpty)
                  _ContactTile(
                    icon: Icons.calendar_month,
                    label: l10n.bookCall,
                    value: contact.calendly,
                    onTap: () => launchExternal(contact.calendly),
                  ),
                if (contact.email.isNotEmpty)
                  _ContactTile(
                    icon: Icons.email,
                    label: l10n.sendEmail,
                    value: contact.email,
                    onTap: () => launchExternal(
                      'mailto:${contact.email}'
                      '?subject=${Uri.encodeComponent(l10n.emailSubject)}'
                      '&body=${l10n.emailBody}',
                    ),
                  ),
                if (contact.linkedin.isNotEmpty)
                  _ContactTile(
                    icon: Icons.business,
                    label: l10n.seeLinkedIn,
                    value: contact.linkedin,
                    onTap: () => launchExternal(contact.linkedin),
                  ),
                if (contact.github.isNotEmpty)
                  _ContactTile(
                    icon: Icons.code,
                    label: l10n.seeGitHub,
                    value: contact.github,
                    onTap: () => launchExternal(contact.github),
                  ),
                if (contact.cvShortUrl.isNotEmpty)
                  _ContactTile(
                    icon: Icons.picture_as_pdf,
                    label: l10n.downloadShortCV,
                    value: contact.cvShortUrl,
                    onTap: () => launchExternal(contact.cvShortUrl),
                  ),
                if (contact.cvFullUrl.isNotEmpty)
                  _ContactTile(
                    icon: Icons.description,
                    label: l10n.downloadFullCV,
                    value: contact.cvFullUrl,
                    onTap: () => launchExternal(contact.cvFullUrl),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(value),
        onTap: onTap,
      ),
    );
  }
}
