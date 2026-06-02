import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/api_keys.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/data/models/responses/forget_password_response.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/domain/use_cases/verify_code_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'forget_password_state.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final VerifyCodeUseCase confirmValidationCodeUseCase;

  ForgetPasswordViewModel({
    required this.forgetPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.confirmValidationCodeUseCase,
  }) : super(ForgetPasswordState());

  Future<void> forgetPassword(Map<String, dynamic> body) async {
    emit(
      state.copyWith(
        forgetPasswordState: state.forgetPasswordState.copyWith(
          isLoading: true,
        ),
      ),
    );

    final response = await forgetPasswordUseCase(body);

    switch (response) {
      case SuccessBaseResponse<ForgetPasswordResponse>():
        final secure = getIt.get<SecureStorageService>();
        secure.write(key: "userEmail", value: body[ApiKeys.email]);

        emit(
          state.copyWith(
            forgetPasswordState: state.forgetPasswordState.copyWith(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<ForgetPasswordResponse>():
        emit(
          state.copyWith(
            forgetPasswordState: state.forgetPasswordState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> resetPassword(Map<String, dynamic> body) async {
    emit(
      state.copyWith(
        resetPasswordState: state.resetPasswordState.copyWith(isLoading: true),
      ),
    );

    final response = await resetPasswordUseCase(body);

    switch (response) {
      case SuccessBaseResponse<ForgetPasswordResponse>():
        emit(
          state.copyWith(
            resetPasswordState: state.resetPasswordState.copyWith(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<ForgetPasswordResponse>():
        emit(
          state.copyWith(
            resetPasswordState: state.resetPasswordState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> confirmValidationCode({
    required Map<String, dynamic> body,
  }) async {
    emit(
      state.copyWith(
        confirmValidationState: state.confirmValidationState.copyWith(
          isLoading: true,
        ),
      ),
    );

    final response = await confirmValidationCodeUseCase(body);

    switch (response) {
      case SuccessBaseResponse<ForgetPasswordResponse>():
        emit(
          state.copyWith(
            confirmValidationState: state.confirmValidationState.copyWith(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<ForgetPasswordResponse>():
        emit(
          state.copyWith(
            confirmValidationState: state.confirmValidationState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> resendCode() async {
    final email = await getUserEmail();
    await forgetPassword({ApiKeys.email: email});
  }

  Future<String> getUserEmail() async {
    final secure = getIt.get<SecureStorageService>();
    final emailResponse = secure.read(key: 'userEmail');

    switch (emailResponse) {
      case SuccessBaseResponse<String>(data: final email):
        return email;

      case ErrorBaseResponse<String>():
        return '';
    }

    return '';
  }
}
