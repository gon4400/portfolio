import 'package:flutter/material.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(double position) onScrollTo;

  const CustomAppBar({super.key, required this.onScrollTo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Mon Portfolio'),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        TextButton(
          onPressed: () => onScrollTo(100.0),
          child: const Text("À propos", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => onScrollTo(300.0),
          child: const Text("Compétences", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => onScrollTo(500.0),
          child: const Text("Projets", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => onScrollTo(800.0),
          child: const Text("Contact", style: TextStyle(color: Colors.white)),
        ),
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: () {
            final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
            themeProvider.toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
