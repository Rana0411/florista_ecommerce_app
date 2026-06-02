class UserEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String token;
  final String message;
  final String gender;
  final String role;
  final String photo;

  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.token,
    required this.message,
    required this.gender,
    required this.role,
    required this.photo,
  });

  String get fullName => '$firstName $lastName';
}
