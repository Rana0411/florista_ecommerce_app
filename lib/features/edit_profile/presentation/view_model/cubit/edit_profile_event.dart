import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';

sealed class EditProfileEvent {}

class UploadProfileData extends EditProfileEvent {
  final UserRequestDto user;

  UploadProfileData({required this.user});
}

class UploadProfilePhoto extends EditProfileEvent {
  final MultipartFile photo;

  UploadProfilePhoto({required this.photo});
}

class UpdateGender extends EditProfileEvent {
  final String gender;
  UpdateGender({required this.gender});
}

class PickProfilePhoto extends EditProfileEvent {}
