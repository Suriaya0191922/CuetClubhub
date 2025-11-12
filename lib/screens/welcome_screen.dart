import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> features = [
    {
      'title': 'Explore Clubs',
      'subtitle': 'Discover a club for every interest, from coding to climbing.',
      'icon': Icons.group_add_outlined,
      'color': AppColors.accentPrimary,
      'showIcons': false,
    },
    {
      'title': 'Real-time Events',
      'subtitle': 'Never miss out. Get instant notifications for events and meetings.',
      'icon': Icons.event_available_outlined,
      'color': AppColors.navyBlue,
      'showIcons': false,
    },
    {
      'title': 'Stay Connected',
      'subtitle': 'Chat with club members and manage your schedule effortlessly.',
      'icon': Icons.chat_bubble_outline,
      'color': AppColors.accentSecondary,
      'showIcons': true,
      'socialIcons': [
        Icons.message_outlined,
        Icons.notifications_outlined,
        Icons.calendar_today_outlined,
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD4E7D4),
                  Color(0xFFE8F3E8),
                ],
              ),
            ),
          ),

          // Top and Bottom Waves
          ..._buildTopWaves(context),
          ..._buildBottomWaves(context),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // App name - Right aligned
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ClubHub',
                      style: GoogleFonts.poppins(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Feature Cards
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.25, // responsive height
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: features.length,
                        itemBuilder: (context, index) =>
                            _buildFeatureSlide(features[index]),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      features.length,
                      (index) => _buildDot(index),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Bottom Buttons Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Join the Hub!',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navyBlue,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Buttons Row
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accentPrimary,
                                    foregroundColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 4,
                                  ),
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignupScreen(),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.accentPrimary,
                                    side: const BorderSide(
                                      color: AppColors.accentPrimary,
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Feature Slide - FIXED: Wrapped in SingleChildScrollView and adjusted spacing
  Widget _buildFeatureSlide(Map<String, dynamic> feature) {
    final showIcons = feature['showIcons'] as bool? ?? false;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature['icon'] as IconData,
              size: 28,
              color: feature['color'] as Color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            feature['title'] as String,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.navyBlue,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              feature['subtitle'] as String,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.textDark,
                height: 1.3,
              ),
            ),
          ),
          if (showIcons && feature['socialIcons'] != null) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (feature['socialIcons'] as List<IconData>)
                  .map(
                    (icon) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        icon,
                        size: 16,
                        color: feature['color'] as Color,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  // Page Indicator Dots
  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 10.0,
      width: _currentPage == index ? 24.0 : 10.0,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.accentPrimary
            : AppColors.accentSecondary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  // Top Waves
  List<Widget> _buildTopWaves(BuildContext context) {
    final width = MediaQuery.of(context).size.width + 50;
    return [
      Positioned(top: -50, left: -50, right: 0, child: CustomPaint(size: Size(width, 300), painter: TopWavePainter(color: AppColors.primary, opacity: 1.0))),
      Positioned(top: -40, left: -50, right: 0, child: CustomPaint(size: Size(width, 260), painter: TopWavePainter(color: AppColors.primary, opacity: 0.7))),
      Positioned(top: -30, left: -50, right: 0, child: CustomPaint(size: Size(width, 220), painter: TopWavePainter(color: const Color(0xFF4a7bb8), opacity: 0.4))),
      Positioned(top: -20, left: -50, right: 0, child: CustomPaint(size: Size(width, 180), painter: TopWavePainter(color: const Color(0xFF6b9bd1), opacity: 0.2))),
    ];
  }

  // Bottom Waves
  List<Widget> _buildBottomWaves(BuildContext context) {
    final width = MediaQuery.of(context).size.width + 50;
    return [
      Positioned(bottom: -50, left: -50, right: 0, child: CustomPaint(size: Size(width, 250), painter: BottomWavePainter(color: AppColors.primary, opacity: 1.0))),
      Positioned(bottom: -40, left: -50, right: 0, child: CustomPaint(size: Size(width, 210), painter: BottomWavePainter(color: AppColors.primary, opacity: 0.7))),
      Positioned(bottom: -30, left: -50, right: 0, child: CustomPaint(size: Size(width, 170), painter: BottomWavePainter(color: const Color(0xFF4a7bb8), opacity: 0.4))),
      Positioned(bottom: -20, left: -50, right: 0, child: CustomPaint(size: Size(width, 130), painter: BottomWavePainter(color: const Color(0xFF6b9bd1), opacity: 0.2))),
    ];
  }
}

// Top Wave Painter
class TopWavePainter extends CustomPainter {
  final Color color;
  final double opacity;
  TopWavePainter({required this.color, this.opacity = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(opacity)..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.8, size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.4, 0, size.height * 0.6);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Bottom Wave Painter
class BottomWavePainter extends CustomPainter {
  final Color color;
  final double opacity;
  BottomWavePainter({required this.color, this.opacity = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(opacity)..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.2, size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.6, size.width, size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}