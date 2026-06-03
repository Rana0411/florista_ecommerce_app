part of 'edit_profile_view_model.dart';

class EditProfileState extends Equatable {
  final BaseState<UserRequestDto> editProfileState;
  final BaseState<String> uploadProfilePhotoState;
  final String gender;
  final UserRequestDto? initialUser;
  final String? pickedPhotoPath;

  EditProfileState({
    BaseState<UserRequestDto>? editProfileState,
    BaseState<String>? uploadProfilePhotoState,
    this.gender = 'male',
    this.initialUser,
    this.pickedPhotoPath,
  }) : editProfileState =
           editProfileState ?? BaseState<UserRequestDto>(isLoading: false),
       uploadProfilePhotoState =
           uploadProfilePhotoState ?? BaseState<String>(isLoading: false);

  EditProfileState copyWith({
    BaseState<UserRequestDto>? editProfileState,
    BaseState<String>? uploadProfilePhotoState,
    String? gender,
    UserRequestDto? initialUser,
    String? pickedPhotoPath,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      uploadProfilePhotoState:
          uploadProfilePhotoState ?? this.uploadProfilePhotoState,
      gender: gender ?? this.gender,
      initialUser: initialUser ?? this.initialUser,
      pickedPhotoPath: pickedPhotoPath ?? this.pickedPhotoPath,
    );
  }

  @override
  List<Object?> get props => [
    editProfileState,
    uploadProfilePhotoState,
    gender,
    initialUser,
    pickedPhotoPath,
  ];
}
