// ---------------------------------------------
// File: signupModal.dart
// Purpose: Signup modal widget with real authentication
// Integrated with AuthService (Supabase) and real-time navigation
// ---------------------------------------------

import 'package:flutter/material.dart';
import 'package:cv_illegal_logging_project/controller/authservice.com/auth_service.dart';
import 'package:cv_illegal_logging_project/views/admin/dashboard.ad/dashboard_ad.dart';
import 'package:cv_illegal_logging_project/views/forestGuard/dashboard.fg/dashboard_fg.dart';

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

class _SignupViewState extends State<SignupView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showPassword1 = false;
  bool _showPassword2 = false;
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showAlert('Please fill all fields.');
      return;
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
        // Session created immediately — navigate by role
        final displayRole = _getDisplayRole(widget.role);
        _showAlert('Welcome $username! You are signed in as $displayRole.');

        _navigateBasedOnRole(widget.role);
      } else {
        _showAlert('Signup successful! Please check your email for verification.');
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
      color: Colors.black.withValues(alpha: 0.2),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 350,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Signup as ${_getDisplayRole(widget.role)}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Create a new account',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),
                _buildTextField(_usernameController, 'Username', TextInputType.text),
                const SizedBox(height: 12),
                _buildTextField(_emailController, 'Email', TextInputType.emailAddress),
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
                          ? const CircularProgressIndicator(color: Colors.black)
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

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    TextInputType type, {
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        suffixIcon: suffix,
        suffixIconColor: Colors.white70,
      ),
    );
  }
}
