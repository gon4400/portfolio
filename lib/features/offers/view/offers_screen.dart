import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:portfolio/core/widgets/portfolio_state_builder.dart';
import 'package:portfolio/core/widgets/responsive_body.dart';
import 'package:portfolio/features/portfolio/bloc/recruiter_mode_cubit.dart';
import 'package:portfolio/utils/context_l10n.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/utils/url.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PortfolioStateBuilder(
      title: l10n.navOffers,
      builder: (context, data) {
        final isRecruiter = context.watch<RecruiterModeCubit>().state;
        final offer = data.offers;
        final contact = data.contact;
        final theme = Theme.of(context);
        final title =
            offer.title.isNotEmpty ? offer.title : l10n.navOffers;

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                tooltip: l10n.recruiterMode,
                icon: Icon(
                    isRecruiter ? Icons.tune : Icons.tune_outlined),
                onPressed: () =>
                    context.read<RecruiterModeCubit>().toggle(),
              ),
            ],
          ),
          body: ResponsiveBody(
            child: ListView(
              padding: EdgeInsets.all(context.horizontalPadding),
              children: [
                if (offer.intro.isNotEmpty) ...[
                  Text(offer.intro, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 12),
                ],
                if (contact.calendly.isNotEmpty) ...[
                  FilledButton.icon(
                    onPressed: () => launchExternal(contact.calendly),
                    icon: const Icon(Icons.calendar_month),
                    label: Text(l10n.bookCall),
                  ),
                  const SizedBox(height: 12),
                ],
                _InfoCard(
                  icon: Icons.event_available,
                  title: l10n.availability,
                  value: offer.availability,
                ),
                const SizedBox(height: 10),
                _InfoCard(
                  icon: Icons.payments_outlined,
                  title: l10n.tjm,
                  value: offer.tjm,
                ),
                const SizedBox(height: 10),
                _InfoCard(
                  icon: Icons.location_on_outlined,
                  title: l10n.mobility,
                  value: offer.mobility,
                ),
                const SizedBox(height: 16),
                if (offer.contracts.isNotEmpty) ...[
                  Text(l10n.contracts,
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final c in offer.contracts)
                        Chip(
                          label: Text(c),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (offer.services.isNotEmpty) ...[
                  Text(l10n.services,
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...offer.services
                      .take(isRecruiter ? 5 : 999)
                      .map(
                        (s) => Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Icon(
                                    Icons.check_circle_outline,
                                    size: 18),
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(s)),
                            ],
                          ),
                        ),
                      ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(value.isNotEmpty ? value : '—'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
