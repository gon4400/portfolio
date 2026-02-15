import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/widgets/fullscreen_image_viewer.dart';
import 'package:portfolio/core/widgets/portfolio_state_builder.dart';
import 'package:portfolio/core/widgets/project_image.dart';
import 'package:portfolio/core/widgets/responsive_body.dart';
import 'package:portfolio/domain/entities/project.dart';
import 'package:portfolio/features/portfolio/bloc/recruiter_mode_cubit.dart';
import 'package:portfolio/utils/context_l10n.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/utils/url.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PortfolioStateBuilder(
      title: l10n.navProjects,
      builder: (context, data) {
        final project = data.projects.firstWhere(
              (p) => p.id == projectId,
          orElse: () => Project(id: projectId, title: projectId),
        );
        return _Body(project: project);
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isRecruiter = context.watch<RecruiterModeCubit>().state;
    final theme = Theme.of(context);
    final description =
    isRecruiter ? project.shortDescription : project.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        actions: [
          IconButton(
            tooltip: l10n.recruiterMode,
            icon: Icon(isRecruiter ? Icons.tune : Icons.tune_outlined),
            onPressed: () => context.read<RecruiterModeCubit>().toggle(),
          ),
        ],
      ),
      body: ResponsiveBody(
        child: ListView(
          padding: EdgeInsets.all(context.horizontalPadding),
          children: [
            // ── Image header (tap pour agrandir) ──
            GestureDetector(
              onTap: project.imageAsset.isNotEmpty
                  ? () => FullscreenImageViewer.show(
                context,
                project.imageAsset,
              )
                  : null,
              child: ProjectImage(
                asset: project.imageAsset,
                title: project.title,
                width: double.infinity,
                height: 180,
              ),
            ),
            const SizedBox(height: 15),
            Text(project.title, style: theme.textTheme.headlineSmall),
            if (project.role.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Text(project.role, style: theme.textTheme.labelLarge),
              ),
            if (description.isNotEmpty)
              Text(description, style: theme.textTheme.bodyMedium),
            if (project.tags.isNotEmpty) ...[
              const SizedBox(height: 15),
              Text(l10n.skillsSectionTitle,
                  style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final t
                  in project.tags.take(isRecruiter ? 6 : 20))
                    Chip(
                      label: Text(t),
                      visualDensity: VisualDensity.compact,
                    ),
                  if (project.tags.length > (isRecruiter ? 6 : 20))
                    Chip(
                      label: Text(
                        '+${project.tags.length - (isRecruiter ? 6 : 20)}',
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ],
            const SizedBox(height: 15),
            if (project.link.isNotEmpty ||
                (project.repoLink?.isNotEmpty ?? false) ||
                (project.storeLink?.isNotEmpty ?? false)) ...[
              Text(l10n.moreInfo, style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              if (project.link.isNotEmpty)
                _LinkTile(label: l10n.seeProject, url: project.link),
              if (project.repoLink?.isNotEmpty ?? false)
                _LinkTile(
                    label: l10n.seeGitHub, url: project.repoLink ?? ''),
              if (project.storeLink?.isNotEmpty ?? false)
                _LinkTile(
                    label: l10n.seeDetails, url: project.storeLink ?? ''),
            ],
            if (!isRecruiter && project.gallery.isNotEmpty) ...[
              const SizedBox(height: 15),
              Text(l10n.enlargeImage, style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: project.gallery.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final asset = project.gallery[index];
                    return GestureDetector(
                      onTap: () =>
                          FullscreenImageViewer.show(context, asset),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          asset,
                          width: 160,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: const Icon(Icons.link),
      title: Text(label),
      subtitle: Text(url),
      onTap: () => launchExternal(url),
    );
  }
}