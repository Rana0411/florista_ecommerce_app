import '../../domain/models/user_entity.dart';

class SignUpDto {
  final String message;
  final String token;
  final UserDto user;

  SignUpDto({
    required this.message,
    required this.token,
    required this.user,
  });

  factory SignUpDto.fromJson(Map<String, dynamic> json) {
    return SignUpDto(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: UserDto.fromJson(json['user'] ?? {}),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phone: user.phone,
      token: token,
      message: message,
      gender: user.gender,
      role: user.role,
      photo: user.photo,
    );
  }
}

class UserDto {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final String role;
  final String photo;

  UserDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.role,
    required this.photo,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      role: json['role'] ?? '',
      photo: json['photo'] ?? '',
    );
  }
}
