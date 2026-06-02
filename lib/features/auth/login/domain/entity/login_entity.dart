import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? message;
  final String? token;

  const LoginEntity({
    this.message,
    this.token,
  });

  @override
  List<Object?> get props => [message, token];
}
