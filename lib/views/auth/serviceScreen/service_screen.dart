import 'dart:ui';
import 'package:cv_illegal_logging_project/views/auth/oauth/login_modal.dart';
import 'package:cv_illegal_logging_project/views/auth/oauth/signup_modal.dart';
import 'package:cv_illegal_logging_project/views/auth/splashScreen/onBoardingScreen/onboard_screen.dart';
import 'package:cv_illegal_logging_project/views/auth/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:cv_illegal_logging_project/views/auth/splashScreen/splashWidgets/impressionable_button.dart';

class ServiceScreen extends StatefulWidget {
  final String selectedNavItem;
  const ServiceScreen({super.key, required this.selectedNavItem});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool showLogin = false;
  bool showSignup = false;
  String selectedRole = '';
  final int _currentPage = 2; // Track current active page for indicators
  late String selectedNavItem = ''; // or set a default like 'MONITORING'
  // late String selectedNavItem = widget.selectedNavItem;

  @override
  void initState() {
    super.initState();
    selectedNavItem = widget.selectedNavItem;
  }

  void openLogin(String role) {
    setState(() {
      selectedRole = role;
      showLogin = true;
      showSignup = false;
    });
  }

  void openSignup() {
    setState(() {
      showLogin = false;
      showSignup = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define card width and height as fractions of screen size to enable responsiveness
    final cardWidth = screenWidth * 0.28; // about 28% of screen width
    final cardHeight = screenHeight * 0.5; // about 50% of screen height

    return Scaffold(
      body: Stack(
        children: [
          // Background image fills entire screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/3.0x/image7.png',
              fit: BoxFit.cover,
            ),
          ),

          // Dynamically positioned Info Cards using relative sizing

          // First Info Card
          Positioned(
            left: screenWidth * 0.05,
            top: screenHeight * 0.15,
            width: cardWidth,
            height: cardHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              // BackdropFilter blur area size is controlled by Container's width/height
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  // Reduce color opacity and padding to reduce blur background size
                  color: Colors.white.withValues(alpha: 0.45),
                  padding: const EdgeInsets.all(20.0),
                  child: _buildInfoCard(
                    title: 'AI-Powered Monitoring',
                    heading: "Preserving Forests' Future",
                    infoTitle: 'About AI Monitoring',
                    description:
                        'Our computer vision tool monitors forests in real time, detecting illegal logging through remote sensors. The user-friendly platform delivers instant alerts, supports law enforcement, and helps protect ecosystems and biodiversity.',
                  ),
                ),
              ),
            ),
          ),

          // Second Info Card
          Positioned(
            left: screenWidth * 0.38,
            top: screenHeight * 0.15,
            width: cardWidth,
            height: cardHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.45),
                  padding: const EdgeInsets.all(20.0),
                  child: _buildInfoCard(
                    title: 'Sustainable Solutions',
                    heading: "Smart Tech [:for Green Earth]",
                    infoTitle: 'The Vision',
                    description:
                        'We aim to enable data-driven conservation to fight illegal logging worldwide.',
                  ),
                ),
              ),
            ),
          ),

          // Third Info Card
          Positioned(
            left: screenWidth * 0.71,
            top: screenHeight * 0.15,
            width: cardWidth,
            height: cardHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.45),
                  padding: const EdgeInsets.all(20.0),
                  child: _buildInfoCard(
                    title: 'Innovative Impact',
                    heading: "Technology Meets Nature",
                    infoTitle: 'Our Mission',
                    description:
                        'Integrating innovation with sustainability to effectively combat illegal logging, preserving natural habitats.',
                  ),
                ),
              ),
            ),
          ),

          // Top navigation bar
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 18.0,
              ),
              color: Colors.black.withValues(alpha: 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text(
                        'ILLEGAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        ' LOGGING',
                        style: TextStyle(
                          color: Color(0xFF8BC34A),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        ' APP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Navigation Items
                  Row(
                    children: [
                      // PROFILE - Popup Menu with Role Selection
                      PopupMenuButton<String>(
                        onSelected: (role) {
                          openLogin(role);
                          setState(() {
                            selectedNavItem = 'PROFILE';
                          });
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'admin', child: Text('Admin')),
                          PopupMenuItem(
                            value: 'forest-guard',
                            child: Text('Forest Guard'),
                          ),
                        ],
                        offset: const Offset(0, 40),
                        // color: Colors.grey[800],
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        // Fix: Wrap child in Material to ensure tap recognition
                        child: Material(
                          color: Colors.transparent,
                          child: NavBarItem(
                            'PROFILE ▼',
                            isActive: selectedNavItem == 'PROFILE',
                          ),
                        ),
                      ),

                      // MONITORING
                      NavBarItem(
                        'MONITORING',
                        isActive: selectedNavItem == 'MONITORING',
                        onTap: () {
                          setState(() {
                            selectedNavItem = 'MONITORING';
                          });
                        },
                      ),

                      // SERVICES
                      NavBarItem(
                        'SERVICES',
                        isActive: selectedNavItem == 'SERVICES',
                        onTap: () {
                          setState(() {
                            selectedNavItem = 'SERVICES';
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ServiceScreen(
                                selectedNavItem: 'SERVICES',
                              ),
                            ),
                          );
                        },
                      ),

                      // FAQ
                      NavBarItem(
                        'FAQ',
                        isActive: selectedNavItem == 'FAQ',
                        onTap: () {
                          setState(() {
                            selectedNavItem = 'FAQ';
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Right-side headline and description
          Positioned(
            right: 46,
            bottom: 94,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Back\nto Nature.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 12),
                Text(
                  "About Us -\nPreserving Kenya's Forests Future. Our team advances \nsustainable landscape, irrigation, and tree care projects.",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),

          // Navigation buttons
          Positioned(
            right: 40,
            bottom: 40,
            child: Row(
              children: [
                ImpressionableButton(
                  icon: Icons.arrow_back_ios_new,
                  size: 39,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      _createRouteToSplashScreen(),
                    );
                  },
                ),
                const SizedBox(width: 22),
                ImpressionableButton(
                  icon: Icons.arrow_forward_ios,
                  size: 40,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      _createRouteToOnboarding(),
                    );
                  },
                ),
              ],
            ),
          ),

          // Page indicators
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildIndicator(
                      index == _currentPage,
                    ), // Active dot based on _currentPage
                  ),
                ),
              ),
            ),
          ),
          // == PARTIAL BLUR just under modal overlay, matching its size/position ==
          Stack(
            children: [
              // Partial blur appears when either modal is active
              if (showLogin || showSignup)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 000),
                      width: showLogin ? 350 : 351,
                      height: showLogin ? 385 : 450,
                      curve: Curves.easeInOut,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              // ===== Modals Section =====
              if (showLogin)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => showLogin = false),
                  child: LoginView(
                    role: selectedRole,
                    onClose: () => setState(() => showLogin = false),
                    onOpenSignup: openSignup,
                  ),
                ),

              if (showSignup)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => showSignup = false),
                  child: SignupView(
                    key: ValueKey(selectedRole),
                    role: selectedRole,
                    onClose: () => setState(() => showSignup = false),
                    onOpenLogin: () => openLogin(selectedRole),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Info card builder
  Widget _buildInfoCard({
    required String title,
    required String heading,
    required String infoTitle,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          heading,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          infoTitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }

  // Page indicator dot
  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 18 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// Helper Method to create route to SplashScreen
Route _createRouteToSplashScreen() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) =>
        const SplashScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

// Helper method to create a route with slide transition to OnBoardScreen
Route _createRouteToOnboarding() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) =>
        const OnBoardScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide in from left
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

// NavBarItem widget
class NavBarItem extends StatefulWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const NavBarItem(this.text, {super.key, this.isActive = false, this.onTap});

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool isHovered = false; // Track hover state

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isActive || isHovered
                  ? Colors.white
                  : Colors.white70,
              fontWeight: widget.isActive || isHovered
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 16,
              decoration: isHovered
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationColor: Colors.white,
              decorationThickness: 2.0, // make the underline thicker
            ),
          ),
        ),
      ),
    );
  }
}
