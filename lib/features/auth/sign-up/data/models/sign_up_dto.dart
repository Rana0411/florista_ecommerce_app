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
      user: UserDto.fromJson(json['user']),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      name: user.name,
      email: user.email,
      token: token,
      message: message,
    );
  }
}

class UserDto {
  final String name;
  final String email;


  UserDto({
    required this.name,
    required this.email,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}