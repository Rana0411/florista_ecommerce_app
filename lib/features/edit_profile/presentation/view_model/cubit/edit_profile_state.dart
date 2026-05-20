part of 'edit_profile_view_model.dart';

class EditProfileState extends Equatable {
  final BaseState<UserRequestDto> editProfileState;
  final BaseState<String> uploadProfilePhoto;
  final String gender;
  final UserRequestDto? initialUser;

  EditProfileState({
    BaseState<UserRequestDto>? editProfileState,
    BaseState<String>? uploadProfilePhoto,
    this.gender = 'male',
    this.initialUser,
  }) : editProfileState =
           editProfileState ?? BaseState<UserRequestDto>(isLoading: false),
       uploadProfilePhoto =
           uploadProfilePhoto ?? BaseState<String>(isLoading: false);

  EditProfileState copyWith({
    BaseState<UserRequestDto>? editProfileState,
    BaseState<String>? uploadProfilePhoto,
    String? gender,
    UserRequestDto? initialUser,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      uploadProfilePhoto: uploadProfilePhoto ?? this.uploadProfilePhoto,
      gender: gender ?? this.gender,
      initialUser: initialUser ?? this.initialUser,
    );
  }

  @override
  List<Object?> get props => [
    editProfileState,
    uploadProfilePhoto,
    gender,
    initialUser,
  ];
}
