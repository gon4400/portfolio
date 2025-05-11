import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final Map<String, String> project;
  final VoidCallback onTap;

  const ProjectItem({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project['image_asset'] != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  project['image_asset']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project['title'] ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward_sharp),
                    onPressed: onTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
