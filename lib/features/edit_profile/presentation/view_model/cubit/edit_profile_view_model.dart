import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/features/edit_profile/domain/use_cases/upload_profile_data_use_case.dart';
import 'package:florista_ecommerce_app/features/edit_profile/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_event.dart';
import 'package:injectable/injectable.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileState> {
  final UploadProfileDataUseCase uploadProfileData;
  final UploadProfilePhotoUseCase uploadProfilePhotoUseCase;
  EditProfileViewModel({
    required this.uploadProfileData,
    required this.uploadProfilePhotoUseCase,
  }) : super(EditProfileState());

  void doEvent(EditProfileEvent event) {
    switch (event) {
      case UploadProfileData():
        _uploadProfileData(user: event.user);
        break;
      case UploadProfilePhoto():
        _uploadProfilePhoto(photo: event.photo);
        break;

      case UpdateGender():
        emit(state.copyWith(gender: event.gender));
    }
  }

  void initUser(UserRequestDto user) {
    emit(state.copyWith(gender: user.gender ?? 'male', initialUser: user));
  }

  UserRequestDto buildChangedDto({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? phone,
  }) {
    final initial = state.initialUser;
    return UserRequestDto(
      id: null,
      photo: null,
      firstName: firstName != initial?.firstName ? firstName : null,
      lastName: lastName != initial?.lastName ? lastName : null,
      email: email != initial?.email ? email : null,
      phone: phone != initial?.phone ? phone : null,
      gender: state.gender != initial?.gender ? state.gender : null,
    );
  }

  Future<void> _uploadProfileData({required UserRequestDto user}) async {
    emit(
      state.copyWith(
        editProfileState: state.editProfileState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await uploadProfileData(userRequestDto: user);
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        editProfileState: state.editProfileState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> _uploadProfilePhoto({required MultipartFile photo}) async {
    emit(
      state.copyWith(
        uploadProfilePhoto: state.uploadProfilePhoto.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await uploadProfilePhotoUseCase(photo: photo);
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        uploadProfilePhoto: state.uploadProfilePhoto.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}
