
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;
  AuthService._internal();
  final SupabaseClient _client = Supabase.instance.client;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  

  String? fullName;
  String? initials;
  String? email;

  static const _rememberMeKey = 'remember_me';
  static const _refreshTokenKey = 'refresh_token';

  // Sign Up
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
    required String role,
  }) async {
    const allowedRoles = ['admin', 'forest-guard'];
    if (!allowedRoles.contains(role)) {
      throw ArgumentError(
        'Invalid role: $role. Allowed roles are $allowedRoles',
      );
    }
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'username': username, 'role': role},
    );
    return response;
  }

  // Sign In
  Future<AuthResponse> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (res.session != null && rememberMe) {
      await _storage.write(key: _rememberMeKey, value: 'true');
      await _storage.write(
        key: _refreshTokenKey,
        value: res.session!.refreshToken,
      );
    } else {
      await _storage.delete(key: _rememberMeKey);
      await _storage.delete(key: _refreshTokenKey);
    }
    return res;
  }

  // Simple sign-in wrapper
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
    bool rememberMe = true,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.session != null;
  }

  // Sign Out
  Future<void> signOut() async {
    await _client.auth.signOut();
    await _storage.delete(key: _rememberMeKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // Fetch Profile
  Future<Map<String, dynamic>?> fetchProfile() async {
    final uid = _client.auth.currentUser?.id;
    if (uid == null) return null;

    final response = await _client
        .from('profiles')
        .select()
        .eq('id', uid)
        .maybeSingle();

    print('Fetched profile: $response');

    if (response != null) {
      // Try full_name, fallback to username, fallback to email prefix
      fullName = response['username'] ?? '';
      if (fullName == null || fullName!.trim().isEmpty) {
        fullName = response['email']?.split('@')[0] ?? '';
      }

      email = response['email'] ?? '';
      initials = _getInitials(fullName!);
    }

    return response;
  }

  String _getInitials(String name) {
    var parts = name.trim().split(' ');
    if (parts.isNotEmpty) {
      if (parts.length == 1 && parts[0].isNotEmpty) {
        return parts[0].substring(0, 1).toUpperCase();
      }
      return parts
          .where((e) => e.isNotEmpty)
          .map((e) => e[0].toUpperCase())
          .take(2)
          .join();
    }
    return '';
  }

  // Restore Session
  Future<void> restoreSessionIfNeeded() async {
    final rememberMe = await _storage.read(key: _rememberMeKey);
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (rememberMe == 'true' && refreshToken != null) {
      try {
        await _client.auth.setSession(refreshToken);
      } catch (e) {
        await _storage.delete(key: _rememberMeKey);
        await _storage.delete(key: _refreshTokenKey);
      }
    }
  }

  // Remember Me Flag
  Future<void> setRememberMeFlag(bool remember) async {
    if (remember) {
      await _storage.write(key: _rememberMeKey, value: 'true');
    } else {
      await _storage.delete(key: _rememberMeKey);
    }
  }
}
