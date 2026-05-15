import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? id;
  final String? street;
  final String? city;

  const AddressEntity({
    required this.id,
    required this.street,
    required this.city,
  });

  @override
  List<Object?> get props => [id, street, city];
}
