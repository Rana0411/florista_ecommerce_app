
part of 'sign_up_view_model.dart';

class SignUpState {
  BaseState<UserEntity> signUpState =
  BaseState<UserEntity>(isLoading: false);

  SignUpState({
    BaseState<UserEntity>? signUpState,
  }) {
    this.signUpState =
        signUpState ?? BaseState<UserEntity>(isLoading: false);
  }

  SignUpState copyWith({
    BaseState<UserEntity>? signUpState,
  }) {
    return SignUpState(
      signUpState: signUpState ?? this.signUpState,
    );
  }
}