import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:portfolio/core/widgets/portfolio_state_builder.dart';
import 'package:portfolio/core/widgets/project_image.dart';
import 'package:portfolio/core/widgets/responsive_body.dart';
import 'package:portfolio/domain/entities/portfolio_data.dart';
import 'package:portfolio/features/portfolio/bloc/recruiter_mode_cubit.dart';
import 'package:portfolio/utils/context_l10n.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/utils/url.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PortfolioStateBuilder(
      title: l10n.appTitle,
      builder: (context, data) => _Body(data: data),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.data});

  final PortfolioData data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isRecruiter = context.watch<RecruiterModeCubit>().state;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final contact = data.contact;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.recruiterMode,
            onPressed: () => context.read<RecruiterModeCubit>().toggle(),
            icon: Icon(
              isRecruiter ? Icons.tune : Icons.tune_outlined,
              color: isRecruiter ? colorScheme.primary : null,
            ),
          ),
        ],
      ),
      body: ResponsiveBody(
        child: ListView(
          padding: EdgeInsets.all(context.horizontalPadding),
          children: [
            // ── Hero ──
            Text(
              data.hero.greeting.isNotEmpty
                  ? data.hero.greeting
                  : l10n.greeting,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 16),
              child: Text(
                data.hero.tagline.isNotEmpty
                    ? data.hero.tagline
                    : l10n.tagline,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            // ── CTA ──
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (contact.calendly.isNotEmpty)
                  FilledButton.icon(
                    onPressed: () => launchExternal(contact.calendly),
                    icon: const Icon(Icons.calendar_month),
                    label: Text(l10n.bookCall),
                  ),
                if (contact.cvShortUrl.isNotEmpty)
                  OutlinedButton.icon(
                    onPressed: () => launchExternal(contact.cvShortUrl),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: Text(l10n.downloadShortCV),
                  ),
                if (contact.cvFullUrl.isNotEmpty)
                  OutlinedButton.icon(
                    onPressed: () => launchExternal(contact.cvFullUrl),
                    icon: const Icon(Icons.description),
                    label: Text(l10n.downloadFullCV),
                  ),
              ],
            ),
            const SizedBox(height: 32),

            // ── Projects ──
            Text(
              l10n.projectsSectionTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            for (final p in data.projects)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => context.push('/project/${p.id}'),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProjectImage(
                            asset: p.imageAsset,
                            title: p.title,
                            width: 52,
                            height: 52,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        p.title,
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  isRecruiter
                                      ? p.shortDescription
                                      : p.description,
                                  maxLines: isRecruiter ? 2 : 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                if (p.tags.isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: [
                                      for (final t
                                          in p.tags.take(isRecruiter ? 3 : 6))
                                        Chip(
                                          label: Text(t),
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // ── Skills (flat list from all groups) ──
            if (data.skills.isNotEmpty) ...[
              Text(
                l10n.skillsSectionTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final group in data.skills)
                    for (final item in group.items)
                      Chip(
                        label: Text(item),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}
