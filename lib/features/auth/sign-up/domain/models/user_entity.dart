class UserEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String token;
  final String message;

  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.token,
    required this.message,
  });

  String get fullName => '$firstName $lastName';
}