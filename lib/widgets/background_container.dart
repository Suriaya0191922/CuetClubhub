/*import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_image/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
*/

/*import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🖼️ Background image
        Positioned.fill(
          child: Image.asset(
            'assets/background_image/background.png', // your background image
            fit: BoxFit.cover,
          ),
        ),

        // 🌫️ Soft blur effect
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.black.withOpacity(0)), // transparent layer
          ),
        ),

        // 🎨 Gradient overlay for color harmony
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x9914213D), // Deep navy tone (top)
                  Color(0x66FCA311), // Orange-gold tint (bottom)
                ],
              ),
            ),
          ),
        ),

        // 🌟 Main content (your widgets)
        child,
      ],
    );
  }
}*/
/*import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF9FAFB), Color(0xFFE5E9F2), Color(0xFFDDE6F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
*/
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF14213D), // deep navy
            Color(0xFF1F2A57), // slightly lighter navy
            Color(0xFF25304C), // muted steel blue
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.05),
              Colors.transparent,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFCAD2A0), // base accent green
            Color(0xFFD8DEB5), // slightly lighter tone
            Color(0xFFBFC89D), // muted olive tone for depth
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            spreadRadius: 2,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.08), // soft light overlay
              Colors.transparent,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/background_image/canva1.jpg"), // Your image
          fit: BoxFit.cover,
        ),
        gradient: const LinearGradient(
          colors: [Color(0xFFF9FAFB), Color(0xFFE5E9F2), Color(0xFFDDE6F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
*/
