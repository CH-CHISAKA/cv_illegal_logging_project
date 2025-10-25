// ---------------------------------------------
// File: signupModal.dart
// Purpose: Signup modal widget with real authentication
// Integrated with AuthService (Supabase) and real-time navigation
// ---------------------------------------------

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:cv_illegal_logging_project/controller/authservice.com/auth_service.dart';
import 'package:cv_illegal_logging_project/views/admin/dashboard.ad/dashboard_ad.dart';
import 'package:cv_illegal_logging_project/views/forestGuard/dashboard.fg/dashboard_fg.dart';

/// ---------------------------------------------
/// MAIN WIDGET
/// ---------------------------------------------
class SignupView extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onOpenLogin;
  final String role;

  const SignupView({
    super.key,
    required this.onClose,
    required this.onOpenLogin,
    this.role = 'user',
  });

  @override
  State<SignupView> createState() => _SignupViewState();
}

const Map<String, String> _roleDisplayNames = {
  'admin': 'Admin',
  'forest-guard': 'Forest Guard',
};

String _getDisplayRole(String role) {
  return _roleDisplayNames[role.toLowerCase()] ?? 'User';
}

/// ---------------------------------------------
/// STATE
/// ---------------------------------------------
class _SignupViewState extends State<SignupView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showPassword1 = false;
  bool _showPassword2 = false;
  bool _isLoading = false;
  String? _emailSuggestion; // ✅ Added for inline suggestion

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // ✅ Combined validation returning suggestion or error text
  Future<String?> _isValidEmail(String email) async {
    // 1️⃣ Structure check
    if (!EmailValidator.validate(email)) {
      return 'Invalid email format';
    }

    final domain = email.split('@').last.toLowerCase();

    // 2️⃣ Common typo suggestions
    const typoCorrections = {
      'gmai.com': 'gmail.com',
      'gmial.com': 'gmail.com',
      'hotnail.com': 'hotmail.com',
      'yaho.com': 'yahoo.com',
    };

    if (typoCorrections.containsKey(domain)) {
      final suggested = '${email.split("@").first}@${typoCorrections[domain]}';
      return suggested;
    }

    // 3️⃣ DNS lookup (optional)
    try {
      final lookup = await InternetAddress.lookup(domain);
      if (lookup.isEmpty) {
        debugPrint('⚠️ DNS lookup returned empty for $domain');
        // Instead of failing hard, just warn
        return null;
      }
      return null; // valid email
    } catch (e) {
      debugPrint('⚠️ DNS lookup failed for $domain: $e');
      // Fallback: accept as valid if format passed
      return null;
    }
  }

  /// ---------------------------------------------
  /// SIGNUP HANDLER
  /// ---------------------------------------------
  Future<void> _handleSignup() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      _showAlert('Please fill all fields.');
      return;
    }

    // ✅ Validate email with typo detection and DNS check
    final suggestionOrError = await _isValidEmail(email);
    if (suggestionOrError != null) {
      // If result contains '@', it's a suggestion
      if (suggestionOrError.contains('@')) {
        setState(() => _emailSuggestion = suggestionOrError);
      } else {
        _showAlert(suggestionOrError);
      }
      return;
    } else {
      setState(() => _emailSuggestion = null); // Clear suggestion if valid
    }

    if (password != confirm) {
      _showAlert('Passwords do not match.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Perform real Supabase signup
      final res = await _authService.signUp(
        email: email,
        password: password,
        username: username,
        role: widget.role,
      );

      if (res.session != null) {
        final displayRole = _getDisplayRole(widget.role);
        _showAlert('Welcome $username! You are signed in as $displayRole.');
        _navigateBasedOnRole(widget.role);
      } else {
        _showAlert(
          'Signup successful! Please check your email for verification.',
        );
      }
    } catch (e) {
      _showAlert('Signup failed: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateBasedOnRole(String role) {
    if (!mounted) return;

    if (role == 'admin') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardAD()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => DashboardFG()),
        (route) => false,
      );
    }
  }

  /// ---------------------------------------------
  /// ALERT DIALOG
  /// ---------------------------------------------
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

  /// ---------------------------------------------
  /// BUILD
  /// ---------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.2),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 350,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Signup as ${_getDisplayRole(widget.role)}',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Create a new account',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),
                _buildTextField(
                  _usernameController,
                  'Username',
                  TextInputType.text,
                ),
                const SizedBox(height: 12),

                // EMAIL FIELD + INLINE SUGGESTION
                _buildTextField(
                  _emailController,
                  'Email',
                  TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                ),

                // ✅ Inline "Did you mean" suggestion
                if (_emailSuggestion != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        _emailController.text = _emailSuggestion!;
                        setState(() => _emailSuggestion = null);
                      },
                      child: Text(
                        'Did you mean $_emailSuggestion?',
                        style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 12),
                _buildTextField(
                  _passwordController,
                  'Password',
                  TextInputType.visiblePassword,
                  obscure: !_showPassword1,
                  suffix: IconButton(
                    icon: Icon(
                      _showPassword1 ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _showPassword1 = !_showPassword1),
                  ),
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  _confirmController,
                  'Confirm Password',
                  TextInputType.visiblePassword,
                  obscure: !_showPassword2,
                  suffix: IconButton(
                    icon: Icon(
                      _showPassword2 ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _showPassword2 = !_showPassword2),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignup,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.green)
                          : const Text(
                              'Create Account',
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
                      'Already have an account?',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.onOpenLogin,
                      child: const Text(
                        'Login',
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

  /// ---------------------------------------------
  /// TEXT FIELD BUILDER
  /// ---------------------------------------------
  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    TextInputType type, {
    bool obscure = false,
    Widget? suffix,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autocorrect = true,
  }) {
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      cursorWidth: 2.5,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        suffixIcon: suffix,
        suffixIconColor: Colors.white70,
      ),
    );
  }
}


