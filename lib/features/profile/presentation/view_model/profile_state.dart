part of 'profile_view_model.dart';

class ProfileState extends Equatable {
  final BaseState<UserRequestDto> getUserDatastate;

  ProfileState({BaseState<UserRequestDto>? getUserDatastate})
    : getUserDatastate =
          getUserDatastate ?? BaseState<UserRequestDto>(isLoading: true);

  ProfileState copyWith({BaseState<UserRequestDto>? getUserDatastate}) {
    return ProfileState(
      getUserDatastate: getUserDatastate ?? this.getUserDatastate,
    );
  }

  @override
  List<Object> get props => [getUserDatastate];
}
