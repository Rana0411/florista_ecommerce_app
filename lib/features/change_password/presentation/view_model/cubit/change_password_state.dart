part of 'change_password_view_model.dart';

class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordResponse> changePasswordState;
  final String? apiError;

  ChangePasswordState({
    BaseState<ChangePasswordResponse>? changePasswordState,
    this.apiError,
  }) : changePasswordState =
           changePasswordState ??
           BaseState<ChangePasswordResponse>(isLoading: false);

  ChangePasswordState copyWith({
    BaseState<ChangePasswordResponse>? changePasswordState,
    String? apiError,
  }) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
      apiError: apiError,
    );
  }

  @override
  List<Object?> get props => [changePasswordState, apiError];
}
