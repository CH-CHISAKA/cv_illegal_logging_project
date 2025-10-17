// ---------------------------------------------
// File: loginModal.dart
// Purpose: Login modal widget (UI only). Delegates auth/storage
// to services and uses callbacks for open/close.
// ---------------------------------------------

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  final String role;
  final VoidCallback onClose;
  final VoidCallback onOpenSignup;

  const LoginView({
    super.key,
    required this.role,
    required this.onClose,
    required this.onOpenSignup,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

// role_utils.dart (or at the top of your loginModal.dart file)
const Map<String, String> _roleDisplayNames = {
  'admin': 'Admin',
  'forest-guard': 'Forest Guard',
};

String _getDisplayRole(String role) {
  // Use the map to get the display name, defaulting to 'User'
  // for empty or unmapped roles.
  return _roleDisplayNames[role.toLowerCase()] ?? 'User';
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _showPassword = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showAlert('Please enter your username and password.');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final session = {
      'role': widget.role.isNotEmpty ? widget.role : 'user',
      'username': username,
      'rememberMe': _rememberMe,
    };
    await prefs.setString('iluser', session.toString());

    final displayRole = _getDisplayRole(widget.role);
    _showAlert('Logged in as $displayRole');
    widget.onClose();
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
                  'Login as ${_getDisplayRole(widget.role)}',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Enter your credentials',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),
                _buildTextField(
                  controller: _usernameController,
                  hint: 'Username',
                  keyboardType: TextInputType.text,
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
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
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
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
