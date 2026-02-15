import 'package:flutter/material.dart';

import 'package:portfolio/core/widgets/portfolio_state_builder.dart';
import 'package:portfolio/core/widgets/responsive_body.dart';
import 'package:portfolio/utils/context_l10n.dart';
import 'package:portfolio/utils/responsive.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PortfolioStateBuilder(
      title: l10n.skillsSectionTitle,
      builder: (context, data) {
        return Scaffold(
          appBar: AppBar(title: Text(l10n.skillsSectionTitle)),
          body: ResponsiveBody(
            child: ListView(
              padding: EdgeInsets.all(context.horizontalPadding),
              children: [
                for (final group in data.skills)
                  if (group.items.isNotEmpty)
                    _SkillSection(
                      title: group.group,
                      items: group.items,
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SkillSection extends StatelessWidget {
  const _SkillSection({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: items.map((e) => Chip(label: Text(e))).toList(),
          ),
        ],
      ),
    );
  }
}
