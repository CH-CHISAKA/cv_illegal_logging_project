import 'dart:ui';
import 'package:cv_illegal_logging_project/views/auth/oauth/login_modal.dart';
import 'package:cv_illegal_logging_project/views/auth/oauth/signup_modal.dart';
import 'package:cv_illegal_logging_project/views/auth/serviceScreen/service_screen.dart';
import 'package:cv_illegal_logging_project/views/auth/splashScreen/splashWidgets/impressionable_button.dart';
import 'package:cv_illegal_logging_project/views/auth/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  bool showLogin = false;
  bool showSignup = false;
  String selectedRole = '';
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String selectedNavItem = ''; // or set a default like 'MONITORING'

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/3.0x/image4.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),

          // PageView with onboarding pages
          PageView(
            controller: _pageController,
            // Update _currentPage and detect page 1
            onPageChanged: (index) {
              if (index == 1) {
                // Navigate back to SplashScreen when landing on 2nd page
                Navigator.pushReplacement(
                  context,
                  _createRouteToSplashScreen(),
                );
              } else {
                setState(() {
                  _currentPage = index;
                });
              }
            },

            // PageView children: replace 2nd page with empty Container or similar
            children: [
              _buildOnboardPage(
                context,
                titleLeft: 'SAVE OUR',
                image: 'assets/images/3.0x/image4.png',
                titleRight: 'FOREST',
                description:
                    "Forests are the lungs of the surface, home for thousands of unique flora and fauna. Nature needs our protection now more than ever. Conserving forests is key to the survival of all natural ecosystems on earth.",
              ),
              Container(), // Empty container, navigation triggers instantly
              Container(
                color: Colors.green[700]?.withValues(alpha: 0.5),
                child: Center(
                  child: Text(
                    'Page 3 Content',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ],
          ),

          // ImpressionableButton Arrows, positioned at bottom right
          // ImpressionableButton Arrows, positioned at bottom right
          Positioned(
            right: 40,
            bottom: 40,
            child: Row(
              children: [
                // LEFT BUTTON: Goes to Service screen and indicators update
                ImpressionableButton(
                  icon: Icons.arrow_back_ios_new,
                  size: 40,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      _createRouteToServiceScreen(),
                    );
                    setState(() {
                      // You may choose to set indicator to 0 or last, here example sets to last
                      _currentPage = 2;
                    });
                  },
                ),
                const SizedBox(width: 22),
                // RIGHT BUTTON: Goes to SplashScreen and indicators update
                ImpressionableButton(
                  icon: Icons.arrow_forward_ios,
                  size: 40,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      _createRouteToSplashScreen(),
                    );
                    setState(() {
                      _currentPage = 0;
                    });
                  },
                ),
              ],
            ),
          ),

          // Page indicators at bottom center
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

          // Top Navigation Bar (optional to include same header as splash screen)
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ServiceScreen(selectedNavItem: 'SERVICES'),
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

          // == PARTIAL BLUR just under modal overlay, matching its size/position ==
          Stack(
            children: [
              // Partial blur only when modals are shown
              if (showLogin || showSignup)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 000),
                      width: showLogin
                          ? 350
                          : 351, // adjust width dynamically (example)
                      height: showLogin
                          ? 385
                          : 450, // adjust height dynamically (example)
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

  Widget _buildOnboardPage(
    BuildContext context, {
    required String titleLeft,
    required String image,
    required String titleRight,
    required String description,
  }) {
    return Center(
      child: Container(
        width: 950,
        height: 470,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/3.0x/image3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.07),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.13),
                      blurRadius: 16,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: 90,
              left: 35,
              right: 35,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          titleLeft,
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.92),
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: 195,
                          height: 115,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.19),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.green[900],
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleRight,
                            style: const TextStyle(
                              fontSize: 53,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: 370,
                            child: Text(
                              description,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.92),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 29,
                                vertical: 11,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'LEARN MORE',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 38),
                          Row(
                            children: [
                              Icon(
                                Icons.facebook,
                                color: Colors.white.withValues(alpha: 0.9),
                                size: 21,
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.share,
                                color: Colors.white.withValues(alpha: 0.9),
                                size: 21,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

// Helper Method to create route to ServiceScreen
Route _createRouteToServiceScreen() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) =>
        const ServiceScreen(selectedNavItem: ''),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
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
  final VoidCallback? onTap; // Add onTap callback

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
              decorationThickness: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
