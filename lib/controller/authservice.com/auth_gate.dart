import 'package:cv_illegal_logging_project/controller/authservice.com/auth_service.dart';
import 'package:cv_illegal_logging_project/views/admin/dashboard.ad/dashboard_ad.dart';
import 'package:cv_illegal_logging_project/views/auth/oauth/login_modal.dart';
import 'package:cv_illegal_logging_project/views/forestGuard/dashboard.fg/dashboard_fg.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final AuthService _authService = AuthService();
  late final SupabaseClient _client;

  bool _isLoading = true;
  String? _role;

  @override
  void initState() {
    super.initState();
    _client = Supabase.instance.client;

    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    // Try to restore session if "remember me" is set
    await _authService.restoreSessionIfNeeded();

    // Listen for any auth changes
    _client.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      final session = data.session;

      debugPrint('🔄 Auth event: $event');

      if (event == AuthChangeEvent.signedIn && session != null) {
        await _loadUserRole();
        _navigateBasedOnRole();
      } else if (event == AuthChangeEvent.signedOut) {
        _navigateToLogin();
      } else if (event == AuthChangeEvent.tokenRefreshed) {
        debugPrint('✅ Token refreshed');
      }
    });

    // Check current session on app start
    if (_client.auth.currentUser != null) {
      await _loadUserRole();
      _navigateBasedOnRole();
    } else {
      _navigateToLogin();
    }

    setState(() => _isLoading = false);
  }

  Future<void> _loadUserRole() async {
    final profile = await _authService.fetchProfile();
    setState(() {
      _role = profile?['role'];
    });
  }

  void _navigateBasedOnRole() {
    if (!mounted) return;

    if (_role == 'admin') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardAD()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) =>  DashboardFG()),
        (route) => false,
      );
    }
  }

  void _navigateToLogin() {
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = _client.auth.currentUser;
    if (user == null) {
      return const LoginView();
    }

    if (_role == 'admin') {
      return const DashboardAD();
    } else {
      return  DashboardFG();
    }
  }
}
