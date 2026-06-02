import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/secure_storage_keys.dart';
import 'package:injectable/injectable.dart';

abstract interface class LoginLocalDataSource {
  Future<void> persistToken(String token);
}

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SecureStorageService _secureStorage;

  const LoginLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> persistToken(String token) async {
    await _secureStorage.write(
      key: SecureStorageKeys.token,
      value: token,
    );
  }
}
