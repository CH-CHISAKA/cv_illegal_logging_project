// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class AuthService {
//   final SupabaseClient _client = Supabase.instance.client;
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   static const _rememberMeKey = 'remember_me';
//   static const _refreshTokenKey = 'refresh_token';

//   /// --------------------------------------------
//   /// SIGN UP - Create a new user with email & password
//   /// --------------------------------------------
//   Future<AuthResponse> signUp({
//     required String email,
//     required String password,
//     String? username,
//     String role = 'user',
//   }) async {
//     return await _client.auth.signUp(
//       email: email,
//       password: password,
//       data: {'username': username ?? '', 'role': role},
//     );
//   }

//   /// --------------------------------------------
//   /// SIGN IN - Standard email/password sign-in with optional remember me
//   /// --------------------------------------------
//   Future<AuthResponse> signIn({
//     required String email,
//     required String password,
//     bool rememberMe = false,
//   }) async {
//     final res = await _client.auth.signInWithPassword(
//       email: email,
//       password: password,
//     );

//     // Save "remember me" session token if applicable
//     if (res.session != null && rememberMe) {
//       await _storage.write(key: _rememberMeKey, value: 'true');
//       await _storage.write(
//         key: _refreshTokenKey,
//         value: res.session!.refreshToken,
//       );
//     } else {
//       await _storage.delete(key: _rememberMeKey);
//       await _storage.delete(key: _refreshTokenKey);
//     }

//     return res;
//   }

//   /// --------------------------------------------
//   /// SIMPLE SIGN-IN WRAPPER (returns bool)
//   /// Used by LoginView for quick success/fail logic
//   /// --------------------------------------------
//   Future<bool> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//     bool rememberMe = true,
//   }) async {
//     final response = await _client.auth.signInWithPassword(
//       email: email,
//       password: password,
//     );
//     return response.session != null;
//   }

//   /// --------------------------------------------
//   /// SIGN OUT - End current session and clear stored data
//   /// --------------------------------------------
//   Future<void> signOut() async {
//     await _client.auth.signOut();
//     await _storage.delete(key: _rememberMeKey);
//     // await _storage.delete(key: _refreshTokenKey); // optional
//   }

//   /// --------------------------------------------
//   /// FETCH PROFILE - Returns user data from 'profiles' table
//   /// --------------------------------------------
//   Future<Map<String, dynamic>?> fetchProfile() async {
//     final uid = _client.auth.currentUser?.id;
//     if (uid == null) return null;

//     final response = await _client
//         .from('profiles')
//         .select()
//         .eq('id', uid)
//         .maybeSingle();

//     return response;
//   }

//   /// --------------------------------------------
//   /// RESTORE SESSION - If remember-me is enabled, reauthenticate silently
//   /// --------------------------------------------
//   Future<void> restoreSessionIfNeeded() async {
//     final rememberMe = await _storage.read(key: _rememberMeKey);
//     final refreshToken = await _storage.read(key: _refreshTokenKey);

//     if (rememberMe == 'true' && refreshToken != null) {
//       try {
//         await _client.auth.setSession(refreshToken);
//       } catch (e) {
//         await _storage.delete(key: _rememberMeKey);
//         await _storage.delete(key: _refreshTokenKey);
//       }
//     }
//   }

//   /// --------------------------------------------
//   /// REMEMBER ME FLAG - Save or remove user preference
//   /// --------------------------------------------
//   Future<void> setRememberMeFlag(bool remember) async {
//     if (remember) {
//       await _storage.write(key: _rememberMeKey, value: 'true');
//     } else {
//       await _storage.delete(key: _rememberMeKey);
//     }
//   }
// }


import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// ----------------------------
/// AuthService: Handles Signup, Login, Logout, and Profile Fetching
/// ----------------------------
class AuthService {
  final SupabaseClient _client = Supabase.instance.client;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _rememberMeKey = 'remember_me';
  static const _refreshTokenKey = 'refresh_token';

  /// ----------------------------
  /// SIGN UP - Create a new user with email & password
  /// ----------------------------
  // Future<AuthResponse> signUp({
  //   required String email,
  //   required String password,
  //   String? username,
  //   String role = 'user',
  // }) async {
  //   return await _client.auth.signUp(
  //     email: email,
  //     password: password,
  //     data: {'username': username ?? '', 'role': role}, // Supabase metadata
  //   );
  // }
  Future<AuthResponse> signUp({
  required String email,
  required String password,
  required String username,
  required String role, // must be one of the allowed roles
}) async {
  // Validate the role explicitly
  const allowedRoles = ['admin', 'forest-guard'];
  if (!allowedRoles.contains(role)) {
    throw ArgumentError('Invalid role: $role. Allowed roles are $allowedRoles');
  }

  // Send signup request with guaranteed role in metadata
  final response = await _client.auth.signUp(
    email: email,
    password: password,
    data: {
      'username': username,
      'role': role, // guaranteed valid
    },
  );

  return response;
}


  /// ----------------------------
  /// SIGN IN - Standard email/password sign-in with optional remember me
  /// ----------------------------
  Future<AuthResponse> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    // Save "remember me" session token if applicable
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

  /// ----------------------------
  /// SIMPLE SIGN-IN WRAPPER (returns bool)
  /// Used by UI for success/fail logic
  /// ----------------------------
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

  /// ----------------------------
  /// SIGN OUT - End current session and clear stored data
  /// ----------------------------
  Future<void> signOut() async {
    await _client.auth.signOut();
    await _storage.delete(key: _rememberMeKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  /// ----------------------------
  /// FETCH PROFILE - Returns user data from 'profiles' table
  /// ----------------------------
  Future<Map<String, dynamic>?> fetchProfile() async {
    final uid = _client.auth.currentUser?.id;
    if (uid == null) return null;

    final response = await _client
        .from('profiles')
        .select()
        .eq('id', uid)
        .maybeSingle();

    return response;
  }

  /// ----------------------------
  /// RESTORE SESSION - Reauthenticate silently if "remember me" is set
  /// ----------------------------
  Future<void> restoreSessionIfNeeded() async {
    final rememberMe = await _storage.read(key: _rememberMeKey);
    final refreshToken = await _storage.read(key: _refreshTokenKey);

    if (rememberMe == 'true' && refreshToken != null) {
      try {
        await _client.auth.setSession(refreshToken);
      } catch (e) {
        // Clear invalid session tokens
        await _storage.delete(key: _rememberMeKey);
        await _storage.delete(key: _refreshTokenKey);
      }
    }
  }

  /// ----------------------------
  /// REMEMBER ME FLAG - Save or remove user preference
  /// ----------------------------
  Future<void> setRememberMeFlag(bool remember) async {
    if (remember) {
      await _storage.write(key: _rememberMeKey, value: 'true');
    } else {
      await _storage.delete(key: _rememberMeKey);
    }
  }
}
