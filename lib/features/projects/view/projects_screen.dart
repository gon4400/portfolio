import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/widgets/portfolio_state_builder.dart';
import 'package:portfolio/core/widgets/project_image.dart';
import 'package:portfolio/core/widgets/responsive_body.dart';
import 'package:portfolio/features/portfolio/bloc/recruiter_mode_cubit.dart';
import 'package:portfolio/utils/context_l10n.dart';
import 'package:portfolio/utils/responsive.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PortfolioStateBuilder(
      title: l10n.navProjects,
      builder: (context, data) {
        final isRecruiter = context.watch<RecruiterModeCubit>().state;
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.navProjects),
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
            child: ListView.separated(
              padding: EdgeInsets.all(context.horizontalPadding),
              itemCount: data.projects.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final p = data.projects[index];
                return Card(
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
                            width: 54,
                            height: 54,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        p.title,
                                        style: theme
                                            .textTheme.titleMedium,
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  isRecruiter
                                      ? p.shortDescription
                                      : p.description,
                                  maxLines: isRecruiter ? 2 : 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (p.tags.isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  _Badges(
                                    tags: p.tags,
                                    max: isRecruiter ? 3 : 8,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Badges extends StatelessWidget {
  const _Badges({required this.tags, required this.max});

  final List<String> tags;
  final int max;

  @override
  Widget build(BuildContext context) {
    final shown = tags.take(max).toList();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final t in shown)
          Chip(label: Text(t), visualDensity: VisualDensity.compact),
        if (tags.length > max)
          Chip(
            label: Text('+${tags.length - max}'),
            visualDensity: VisualDensity.compact,
          ),
      ],
    );
  }
}