import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget qui affiche l'image d'un projet en gérant :
/// - SVG (`.svg`)
/// - Images raster (`.png`, `.jpg`, etc.)
/// - Fallback avec initiales si asset vide ou introuvable
class ProjectImage extends StatelessWidget {
  const ProjectImage({
    super.key,
    required this.asset,
    required this.title,
    this.width = 52,
    this.height = 52,
    this.borderRadius = 10,
  });

  final String asset;
  final String title;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    if (asset.isEmpty) return _Fallback(title: title, size: width);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: asset.endsWith('.svg')
          ? SvgPicture.asset(
        asset,
        width: width,
        height: height,
        fit: BoxFit.contain,
        placeholderBuilder: (_) => _Fallback(title: title, size: width),
      )
          : Image.asset(
        asset,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            _Fallback(title: title, size: width),
      ),
    );
  }
}

/// Pastille colorée avec les initiales du projet.
class _Fallback extends StatelessWidget {
  const _Fallback({required this.title, required this.size});

  final String title;
  final double size;

  bool get _isFinite => size.isFinite;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: _isFinite ? size : double.infinity,
      height: _isFinite ? size : 120,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        _initials(title),
        style: TextStyle(
          color: colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
          fontSize: _isFinite ? size * 0.35 : 32,
        ),
      ),
    );
  }

  String _initials(String text) {
    final words = text.trim().split(RegExp(r'\s+'));
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return text.length >= 2
        ? text.substring(0, 2).toUpperCase()
        : text.toUpperCase();
  }
}