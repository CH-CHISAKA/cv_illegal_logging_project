

// import 'package:flutter/material.dart';
// import 'package:cv_illegal_logging_project/controller/authservice.com/auth_service.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:cv_illegal_logging_project/views/admin/dashboard.ad/dashboard_ad.dart';
// import 'package:cv_illegal_logging_project/views/forestGuard/dashboard.fg/dashboard_fg.dart';
// import 'package:email_validator/email_validator.dart'; // ← Added

// class LoginView extends StatefulWidget {
//   final String? role; // Optional, will be used for display
//   final VoidCallback onClose;
//   final VoidCallback onOpenSignup;

//   const LoginView({
//     super.key,
//     this.role,
//     this.onClose = _noop,
//     this.onOpenSignup = _noop,
//   });

//   static void _noop() {}

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// const Map<String, String> _roleDisplayNames = {
//   'admin': 'Admin',
//   'forest-guard': 'Forest Guard',
// };

// String _getDisplayRole(String? role) {
//   if (role == null) return 'User';
//   return _roleDisplayNames[role.toLowerCase()] ?? 'User';
// }

// class _LoginViewState extends State<LoginView> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _rememberMe = true;
//   bool _showPassword = false;
//   bool _isLoading = false;

//   final AuthService _authService = AuthService();
//   late final SupabaseClient _client;

//   @override
//   void initState() {
//     super.initState();
//     _client = Supabase.instance.client;
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   // -----------------------------
//   // Enhanced Email Validation
//   // -----------------------------
//   Future<bool> _isValidEmail(String email) async {
//     // 1️⃣ Basic structure check
//     if (!EmailValidator.validate(email)) return false;

//     // 2️⃣ Common typo correction suggestions
//     const typoCorrections = {
//       'gmai.com': 'gmail.com',
//       'gmial.com': 'gmail.com',
//       'hotnail.com': 'hotmail.com',
//       'yaho.com': 'yahoo.com',
//     };

//     final domain = email.split('@').last.toLowerCase();
//     if (typoCorrections.containsKey(domain)) {
//       _showAlert(
//           'Did you mean ${email.split("@").first}@${typoCorrections[domain]}?');
//       return false;
//     }

//     // ✅ Option 1: Skip DNS check for login
//     return true;
//   }

//   Future<void> _handleLogin() async {
//     final username = _usernameController.text.trim();
//     final password = _passwordController.text;

//     if (username.isEmpty || password.isEmpty) {
//       _showAlert('Please enter your username and password.');
//       return;
//     }

//     // ← Use enhanced email validation
//     if (!await _isValidEmail(username)) {
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final success = await _authService.signInWithEmailAndPassword(
//         email: username,
//         password: password,
//         rememberMe: _rememberMe,
//       );

//       if (!success) {
//         _showAlert('Invalid credentials. Please try again.');
//         return;
//       }

//       // Fetch profile and navigate
//       final profile = await _authService.fetchProfile();
//       final role = profile?['role']?.toLowerCase() ?? 'forest-guard';

//       _navigateBasedOnRole(role);
//     } catch (e) {
//       _showAlert('Login failed: ${e.toString()}');
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _navigateBasedOnRole(String role) {
//     if (!mounted) return;

//     if (role == 'admin') {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (_) => const DashboardAD()),
//         (route) => false,
//       );
//     } else if (role == 'forest-guard') {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (_) => const DashboardFG()),
//         (route) => false,
//       );
//     } else {
//       _showAlert('Unknown role: $role');
//     }
//   }

//   void _showAlert(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black.withOpacity(0.2),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Container(
//           width: 350,
//           margin: const EdgeInsets.all(16),
//           padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.18),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Login as ${_getDisplayRole(widget.role)}',
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall
//                       ?.copyWith(color: Colors.white),
//                 ),
//                 const SizedBox(height: 6),
//                 const Text(
//                   'Enter your credentials',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 const SizedBox(height: 18),
//                 _buildTextField(
//                   controller: _usernameController,
//                   hint: 'Email',
//                   keyboardType: TextInputType.emailAddress,
//                   textCapitalization: TextCapitalization.none,
//                   autocorrect: false,
//                 ),
//                 const SizedBox(height: 12),
//                 _buildTextField(
//                   controller: _passwordController,
//                   hint: 'Password',
//                   keyboardType: TextInputType.visiblePassword,
//                   obscure: !_showPassword,
//                   suffix: IconButton(
//                     icon: Icon(
//                       _showPassword ? Icons.visibility_off : Icons.visibility,
//                     ),
//                     onPressed: () =>
//                         setState(() => _showPassword = !_showPassword),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: _rememberMe,
//                       onChanged: (val) =>
//                           setState(() => _rememberMe = val ?? true),
//                       checkColor: Colors.black,
//                       activeColor: Colors.white,
//                     ),
//                     const Text(
//                       'Remember me',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _handleLogin,
//                     style: ElevatedButton.styleFrom(
//                       shape: const StadiumBorder(),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 12.0),
//                       child: _isLoading
//                           ? const CircularProgressIndicator(color: Colors.black)
//                           : const Text(
//                               'Login',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 Row(
//                   children: [
//                     const Text(
//                       'Don’t have an account?',
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                     const SizedBox(width: 8),
//                     GestureDetector(
//                       onTap: widget.onOpenSignup,
//                       child: const Text(
//                         'Signup',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//     required TextInputType keyboardType,
//     bool obscure = false,
//     Widget? suffix,
//     TextCapitalization textCapitalization = TextCapitalization.none,
//     bool autocorrect = true,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscure,
//       textCapitalization: textCapitalization,
//       style: const TextStyle(color: Colors.white),
//       cursorColor: Colors.white,
//       cursorWidth: 2.5,
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.white70),
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.15),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         suffixIcon: suffix,
//         suffixIconColor: Colors.white70,
//       ),
//     );
//   }
// }

// File: loginModal.dart

import 'package:flutter/material.dart';
import 'package:cv_illegal_logging_project/controller/authservice.com/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cv_illegal_logging_project/views/admin/dashboard.ad/dashboard_ad.dart';
import 'package:cv_illegal_logging_project/views/forestGuard/dashboard.fg/dashboard_fg.dart';
import 'package:email_validator/email_validator.dart';

class LoginView extends StatefulWidget {
  final String? role; // Optional
  final VoidCallback onClose;
  final VoidCallback onOpenSignup;

  const LoginView({
    super.key,
    this.role,
    this.onClose = _noop,
    this.onOpenSignup = _noop,
  });

  static void _noop() {}

  @override
  State<LoginView> createState() => _LoginViewState();
}

const Map<String, String> _roleDisplayNames = {
  'admin': 'Admin',
  'forest-guard': 'Forest Guard',
};

String _getDisplayRole(String? role) {
  if (role == null) return 'User';
  return _roleDisplayNames[role.toLowerCase()] ?? 'User';
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _showPassword = false;
  bool _isLoading = false;

  final AuthService _authService = AuthService();
  late final SupabaseClient _client;

  @override
  void initState() {
    super.initState();
    _client = Supabase.instance.client;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // -----------------------------
  // Enhanced Email Validation w/ Suggestions
  // -----------------------------
  Future<String?> _checkEmailTypo(String email) async {
    if (!EmailValidator.validate(email)) return null;

    const typoCorrections = {
      'gmai.com': 'gmail.com',
      'gmial.com': 'gmail.com',
      'hotnail.com': 'hotmail.com',
      'yaho.com': 'yahoo.com',
    };

    final parts = email.split('@');
    if (parts.length != 2) return null;

    final domain = parts[1].toLowerCase();
    if (typoCorrections.containsKey(domain)) {
      return '${parts[0]}@${typoCorrections[domain]}';
    }

    return null;
  }

  Future<bool> _validateEmail(String email) async {
    if (email.isEmpty) {
      _showAlert('Please enter your email.');
      return false;
    }

    if (!EmailValidator.validate(email)) {
      _showAlert('Please enter a valid email address.');
      return false;
    }

    final suggestion = await _checkEmailTypo(email);
    if (suggestion != null) {
      final confirmed = await _showConfirmationDialog(
        'Did you mean $suggestion?',
      );
      if (confirmed) {
        _usernameController.text = suggestion;
      }
    }

    return true;
  }

  // -----------------------------
  // Confirmation Dialog
  // -----------------------------
  Future<bool> _showConfirmationDialog(String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // -----------------------------
  // Login Handler
  // -----------------------------
  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showAlert('Please enter your username and password.');
      return;
    }

    if (!await _validateEmail(username)) return;

    setState(() => _isLoading = true);

    try {
      final success = await _authService.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: password,
        rememberMe: _rememberMe,
      );

      if (!success) {
        _showAlert('Invalid credentials. Please try again.');
        return;
      }

      final profile = await _authService.fetchProfile();
      final role = profile?['role']?.toLowerCase() ?? 'forest-guard';

      _navigateBasedOnRole(role);
    } catch (e) {
      _showAlert('Login failed: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateBasedOnRole(String role) {
    if (!mounted) return;

    if (role == 'admin') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardAD()),
        (route) => false,
      );
    } else if (role == 'forest-guard') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardFG()),
        (route) => false,
      );
    } else {
      _showAlert('Unknown role: $role');
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.2),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 350,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login as ${_getDisplayRole(widget.role)}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Enter your credentials',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),
                _buildTextField(
                  controller: _usernameController,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscure: !_showPassword,
                  suffix: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (val) =>
                          setState(() => _rememberMe = val ?? true),
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.green)
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Text(
                      'Don’t have an account?',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.onOpenSignup,
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required TextInputType keyboardType,
    bool obscure = false,
    Widget? suffix,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autocorrect = true,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      textCapitalization: textCapitalization,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      cursorWidth: 2.5,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        suffixIcon: suffix,
        suffixIconColor: Colors.white70,
      ),
    );
  }
}
