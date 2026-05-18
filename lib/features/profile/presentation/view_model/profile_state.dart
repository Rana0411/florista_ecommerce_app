part of 'profile_view_model.dart';

class ProfileState extends Equatable {
  final BaseState<UserDataEntity> getUserDatastate;

  ProfileState({BaseState<UserDataEntity>? getUserDatastate})
    : getUserDatastate =
          getUserDatastate ?? BaseState<UserDataEntity>(isLoading: true);

  ProfileState copyWith({BaseState<UserDataEntity>? getUserDatastate}) {
    return ProfileState(
      getUserDatastate: getUserDatastate ?? this.getUserDatastate,
    );
  }

  @override
  List<Object> get props => [getUserDatastate];
}
