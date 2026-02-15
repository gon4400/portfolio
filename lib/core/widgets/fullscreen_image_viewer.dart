import 'package:flutter/material.dart';

/// Affiche une image en plein écran avec zoom (InteractiveViewer).
/// Appeler via `FullscreenImageViewer.show(context, assetPath)`.
class FullscreenImageViewer extends StatelessWidget {
  const FullscreenImageViewer({super.key, required this.asset});

  final String asset;

  static void show(BuildContext context, String asset) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black87,
        barrierDismissible: true,
        pageBuilder: (_, _, _) => FullscreenImageViewer(asset: asset),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ── Tap background to close ──
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const SizedBox.expand(),
          ),

          // ── Image zoomable ──
          Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.asset(
                asset,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.broken_image,
                  size: 64,
                  color: Colors.white54,
                ),
              ),
            ),
          ),

          // ── Bouton fermer ──
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 8,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
              ),
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}