part of 'forget_password_view_model.dart';

class ForgetPasswordState {
  BaseState<ForgetPasswordResponse> forgetPasswordState =
      BaseState<ForgetPasswordResponse>(isLoading: false);

  BaseState<ForgetPasswordResponse> confirmValidationState =
      BaseState<ForgetPasswordResponse>(isLoading: false);

  BaseState<ForgetPasswordResponse> resetPasswordState =
      BaseState<ForgetPasswordResponse>(isLoading: false);

  ForgetPasswordState({
   BaseState<ForgetPasswordResponse>? forgetPasswordState,
   BaseState<ForgetPasswordResponse>? confirmValidationState,
   BaseState<ForgetPasswordResponse>? resetPasswordState,
  }) {
    this.forgetPasswordState =
        forgetPasswordState ?? this.forgetPasswordState;
    this.confirmValidationState =
        confirmValidationState ?? this.confirmValidationState;
    this.resetPasswordState = resetPasswordState ?? this.resetPasswordState;
  }

  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordResponse>? forgetPasswordState,
    BaseState<ForgetPasswordResponse>? confirmValidationState,
    BaseState<ForgetPasswordResponse>? resetPasswordState,
  }) {
    return ForgetPasswordState(
      forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
      confirmValidationState:
          confirmValidationState ?? this.confirmValidationState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }
}
