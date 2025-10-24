
import 'package:cv_illegal_logging_project/views/auth/oauth/login_modal.dart';
import 'package:cv_illegal_logging_project/views/auth/oauth/signup_modal.dart';
import 'package:cv_illegal_logging_project/views/auth/serviceScreen/service_screen.dart';
import 'package:cv_illegal_logging_project/views/auth/splashScreen/onBoardingScreen/onboard_screen.dart';
import 'package:cv_illegal_logging_project/views/auth/splashScreen/splashWidgets/impressionable_button.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showLogin = false;
  bool showSignup = false;
  String selectedRole = '';
  final int _currentPage = 1;
  String selectedNavItem = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/3.0x/image3.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Container(color: Colors.black.withValues(alpha: 0.5)),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                        ' APP ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: NavBarItem(
                            'PROFILE ▼',
                            isActive: selectedNavItem == 'PROFILE',
                          ),
                        ),
                      ),
                      NavBarItem(
                        'MONITORING',
                        isActive: selectedNavItem == 'MONITORING',
                        onTap: () {
                          setState(() => selectedNavItem = 'MONITORING');
                        },
                      ),
                      NavBarItem(
                        'SERVICES',
                        isActive: selectedNavItem == 'SERVICES',
                        onTap: () {
                          setState(() => selectedNavItem = 'SERVICES');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ServiceScreen(selectedNavItem: 'SERVICES'),
                            ),
                          );
                        },
                      ),
                      NavBarItem(
                        'FAQ',
                        isActive: selectedNavItem == 'FAQ',
                        onTap: () {
                          setState(() => selectedNavItem = 'FAQ');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 40,
            bottom: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Join the Effort to Save Our Forests',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'GRE',
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.green[700]?.withValues(alpha: 0.7),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const Text(
                      'EN',
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
                Text(
                  'ENVIRONMENT',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Preserving Kenya\'s Forests Future. Get Involved Today!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'LEARN MORE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 120,
            top: 55,
            child: Icon(Icons.eco, color: Color(0xFF8BC34A), size: 40),
          ),
          Positioned(
            right: 40,
            bottom: 40,
            child: Row(
              children: [
                ImpressionableButton(
                  icon: Icons.arrow_back_ios_new,
                  size: 40,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      _createRouteToOnboarding(),
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
                      _createRouteToServiceScreen(),
                    );
                  },
                ),
              ],
            ),
          ),
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
                    child: _buildIndicator(index == _currentPage),
                  ),
                ),
              ),
            ),
          ),
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
    );
  }

  Route<Object?> _createRouteToServiceScreen() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ServiceScreen(selectedNavItem: ''),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleTween =
            Tween<double>(begin: 0.8, end: 1.0).chain(CurveTween(curve: Curves.easeOut));
        final fadeTween =
            Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut));

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
    );
  }
}

Route _createRouteToOnboarding() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) => const OnBoardScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final scaleTween =
          Tween<double>(begin: 0.8, end: 1.0).chain(CurveTween(curve: Curves.easeOut));
      final fadeTween =
          Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut));

      return FadeTransition(
        opacity: animation.drive(fadeTween),
        child: ScaleTransition(
          scale: animation.drive(scaleTween),
          child: child,
        ),
      );
    },
  );
}

class NavBarItem extends StatefulWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const NavBarItem(this.text, {super.key, this.isActive = false, this.onTap});

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool isHovered = false;

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
              color: widget.isActive || isHovered ? Colors.white : Colors.white70,
              fontWeight: widget.isActive || isHovered
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 16,
              decoration: isHovered ? TextDecoration.underline : TextDecoration.none,
              decorationColor: Colors.white,
              decorationThickness: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
