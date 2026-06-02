import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/secure_storage_keys.dart';

import '../../domain/models/user_entity.dart';
import '../../domain/use_cases/sign_up_use_cases.dart';

part 'sign_up_state.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  SignUpViewModel({
    required this.signUpUseCases,
    required this.secureStorageService,
  }) : super(SignUpState());

  final SignUpUseCases signUpUseCases;
  final SecureStorageService secureStorageService;

  Future<void> clearError() async {
    emit(
      state.copyWith(
        signUpState: BaseState<UserEntity>(
          isLoading: false,
        ),
      ),
    );
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String gender,
  }) async {
    emit(
      state.copyWith(
        signUpState: state.signUpState.copyWith(
          isLoading: true,
        ),
      ),
    );

    final response = await signUpUseCases(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      gender: gender,
    );

    switch (response) {
      case SuccessBaseResponse<UserEntity>():
        await secureStorageService.write(
          key: SecureStorageKeys.token,
          value: response.data.token,
        );

        emit(
          state.copyWith(
            signUpState: BaseState<UserEntity>(
              isLoading: false,
              data: response.data,
              errorMessage: null,
            ),
          ),
        );

      case ErrorBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            signUpState: BaseState<UserEntity>(
              isLoading: false,
              data: null,
              errorMessage: response.errorMessage ?? response.getErrorMessage(),
            ),
          ),
        );
    }
  }
}
