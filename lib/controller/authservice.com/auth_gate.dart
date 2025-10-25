import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cv_illegal_logging_project/controller/authservice.com/auth_service.dart';
import 'package:cv_illegal_logging_project/views/admin/dashboard.ad/dashboard_ad.dart';
import 'package:cv_illegal_logging_project/views/forestGuard/dashboard.fg/dashboard_fg.dart';
import 'package:cv_illegal_logging_project/views/auth/oauth/login_modal.dart';

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
    await _authService.restoreSessionIfNeeded();

    _client.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      final session = data.session;
      debugPrint('🔄 Auth event: $event');

      if (event == AuthChangeEvent.signedIn && session != null) {
        await _loadUserProfileAndRole();
        _navigateBasedOnRole();
      } else if (event == AuthChangeEvent.signedOut) {
        _navigateToLogin();
      }
    });

    if (_client.auth.currentUser != null) {
      await _loadUserProfileAndRole();
      _navigateBasedOnRole();
    } else {
      _navigateToLogin();
    }

    setState(() => _isLoading = false);
  }

  Future<void> _loadUserProfileAndRole() async {
    final profile = await _authService.fetchProfile();
    setState(() {
      _role = profile?['role']?.toLowerCase();
    });
  }

  Future<void> _navigateBasedOnRole() async {
    if (!mounted) return;

    switch (_role) {
      // case 'admin':
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (_) => DashboardAD(
      //         fullName: _authService.fullName ?? '',
      //         initials: _authService.initials ?? '',
      //         email: _authService.email ?? '',
      //       ),
      //     ),
      //     (route) => false,
      //   );
      //   break;
      case 'admin':
        final profile = await _authService.fetchProfile(); // <-- get latest
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => DashboardAD(
              fullName: profile?['username'] ?? _authService.fullName ?? '',
              initials: _authService.initials ?? '',
              email: profile?['email'] ?? _authService.email ?? '',
            ),
          ),
          (route) => false,
        );
        break;

      case 'forest-guard':
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const DashboardFG()),
          (route) => false,
        );
        break;
      default:
        _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginView(role: _role)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final user = _client.auth.currentUser;

    if (user == null) {
      return LoginView(role: _role);
    }

    if (_role == 'admin') {
      return DashboardAD(
        fullName: _authService.fullName ?? '',
        initials: _authService.initials ?? '',
        email: _authService.email ?? '',
      );
    }
    if (_role == 'forest-guard') return const DashboardFG();

    return LoginView(role: _role);
  }
}
