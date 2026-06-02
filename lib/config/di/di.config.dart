// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/forget_password/api/api_client/forget_password_api_client.dart'
    as _i478;
import '../../features/auth/forget_password/api/date_source/forget_password_data_source_impl.dart'
    as _i847;
import '../../features/auth/forget_password/data/data_source/forget_password_data_source_contract.dart'
    as _i170;
import '../../features/auth/forget_password/data/repo/forget_password_repo_impl.dart'
    as _i610;
import '../../features/auth/forget_password/domain/repo/forget_password_repo_contract.dart'
    as _i665;
import '../../features/auth/forget_password/domain/use_cases/forget_password_use_case.dart'
    as _i913;
import '../../features/auth/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i22;
import '../../features/auth/forget_password/domain/use_cases/verify_code_use_case.dart'
    as _i513;
import '../../features/auth/forget_password/presentation/view_model/forget_password_view_model.dart'
    as _i1033;
import '../dio/dio_module.dart' as _i977;
import '../hive/hive_service.dart' as _i746;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.singleton<_i746.HiveService>(() => _i746.HiveService());
    gh.singleton<_i478.ForgetPasswordApiClient>(
      () => _i478.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i170.ForgetPasswordDataSourceContract>(
      () => _i847.ForgetPasswordDataSourceImpl(
        forgetPasswordApiClient: gh<_i478.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i665.ForgetPasswordRepoContract>(
      () => _i610.ForgetPasswordRepoImpl(
        forgetPasswordDataSource: gh<_i170.ForgetPasswordDataSourceContract>(),
      ),
    );
    gh.factory<_i913.ForgetPasswordUseCase>(
      () => _i913.ForgetPasswordUseCase(
        forgetPasswordRepo: gh<_i665.ForgetPasswordRepoContract>(),
      ),
    );
    gh.factory<_i22.ResetPasswordUseCase>(
      () => _i22.ResetPasswordUseCase(
        forgetPasswordRepo: gh<_i665.ForgetPasswordRepoContract>(),
      ),
    );
    gh.factory<_i513.VerifyCodeUseCase>(
      () => _i513.VerifyCodeUseCase(
        forgetPasswordRepo: gh<_i665.ForgetPasswordRepoContract>(),
      ),
    );
    gh.factory<_i1033.ForgetPasswordViewModel>(
      () => _i1033.ForgetPasswordViewModel(
        forgetPasswordUseCase: gh<_i913.ForgetPasswordUseCase>(),
        resetPasswordUseCase: gh<_i22.ResetPasswordUseCase>(),
        confirmValidationCodeUseCase: gh<_i513.VerifyCodeUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}
