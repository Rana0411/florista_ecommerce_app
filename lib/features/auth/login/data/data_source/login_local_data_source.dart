import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/secure_storage_keys.dart';
import 'package:injectable/injectable.dart';

/// Credentials pre-filled on the login screen when "remember me" was
/// checked on a previous login. [rememberMe] is false whenever nothing
/// is remembered, in which case [email]/[password] are null.
class RememberedCredentials {
  final String? email;
  final String? password;
  final bool rememberMe;

  const RememberedCredentials({
    this.email,
    this.password,
    required this.rememberMe,
  });

  static const none = RememberedCredentials(rememberMe: false);
}

abstract interface class LoginLocalDataSource {
  /// Persists the auth [token]. When [rememberMe] is true the token is
  /// written to secure storage; when false, any previously stored token
  /// is cleared.
  Future<void> persistToken(String token, {required bool rememberMe});

  /// When [rememberMe] is true, saves [email]/[password] (and the flag
  /// itself) so the login screen can pre-fill them next launch. When
  /// false, clears any previously remembered credentials.
  Future<void> persistCredentials({
    required String email,
    required String password,
    required bool rememberMe,
  });

  /// Reads back whatever was saved by [persistCredentials]. Returns
  /// [RememberedCredentials.none] if nothing is remembered.
  Future<RememberedCredentials> getRememberedCredentials();
}

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SecureStorageService _secureStorage;

  const LoginLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> persistToken(String token, {required bool rememberMe}) async {
    if (rememberMe) {
      await _secureStorage.write(
        key: SecureStorageKeys.token,
        value: token,
      );
    } else {
      await _secureStorage.delete(key: SecureStorageKeys.token);
    }
  }

  @override
  Future<void> persistCredentials({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    if (rememberMe) {
      await _secureStorage.write(
        key: SecureStorageKeys.rememberedEmail,
        value: email,
      );
      await _secureStorage.write(
        key: SecureStorageKeys.rememberedPassword,
        value: password,
      );
      await _secureStorage.write(
        key: SecureStorageKeys.rememberMe,
        value: 'true',
      );
    } else {
      // Clear out any stale remembered credentials from a previous login.
      await _secureStorage.delete(key: SecureStorageKeys.rememberedEmail);
      await _secureStorage.delete(key: SecureStorageKeys.rememberedPassword);
      await _secureStorage.delete(key: SecureStorageKeys.rememberMe);
    }
  }

  @override
  Future<RememberedCredentials> getRememberedCredentials() async {
    try {
      final flagResult =
          await _secureStorage.read(key: SecureStorageKeys.rememberMe);
      final rememberMe = switch (flagResult) {
        SuccessBaseResponse(:final data) => data == 'true',
        ErrorBaseResponse() => false,
      };

      if (!rememberMe) return RememberedCredentials.none;

      final emailResult =
          await _secureStorage.read(key: SecureStorageKeys.rememberedEmail);
      final passwordResult = await _secureStorage.read(
        key: SecureStorageKeys.rememberedPassword,
      );

      final email = switch (emailResult) {
        SuccessBaseResponse(:final data) => data,
        ErrorBaseResponse() => null,
      };
      final password = switch (passwordResult) {
        SuccessBaseResponse(:final data) => data,
        ErrorBaseResponse() => null,
      };

      return RememberedCredentials(
        email: email,
        password: password,
        rememberMe: true,
      );
    } catch (_) {
      return RememberedCredentials.none;
    }
  }
}
