// ---------------------------------------------
// File: signupModal.dart
// Purpose: Signup modal widget (UI only). Delegates auth/storage
// to services and uses callbacks for open/close.
// ---------------------------------------------

import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  // Add the onClose callback here.
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

// Define the map for role display names at the top of the file
const Map<String, String> _roleDisplayNames = {
  'admin': 'Admin',
  'forest-guard': 'Forest Guard',
};

// Function to format the role string for display
String _getDisplayRole(String role) {
  // Use the map to get the display name, defaulting to 'User'
  // for empty or unmapped roles.
  return _roleDisplayNames[role.toLowerCase()] ?? 'User';
}

class _SignupViewState extends State<SignupView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  // Define separate boolean variables for each password field
  bool _showPassword1 = false;
  bool _showPassword2 = false;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleSignup() {
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

    if (password != confirm) {
      _showAlert('Passwords do not match.');
      return;
    }

    // Format the role using the helper function before showing the alert
    final displayRole = _getDisplayRole(widget.role);
    _showAlert('Account created for $username as a $displayRole.');
    // Additional signup logic goes here
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
                  'Signup',
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
                _buildTextField(
                  _emailController,
                  'Email',
                  TextInputType.emailAddress,
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
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
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
      // This changes the color of the text the user types into the field
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        // This changes the color of the hint text
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
        // This changes the color of the suffix icon
        suffixIconColor: Colors.white70,
      ),
    );
  }
}
