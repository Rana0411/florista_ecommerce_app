import 'package:equatable/equatable.dart';

class BestSellerEntity extends Equatable {
  final String? id;
  final String? title;
  final String? imgCover;
  final int? price;

  const BestSellerEntity({
    required this.id,
    required this.title,
    required this.imgCover,
    required this.price,
  });

  @override
  List<Object?> get props => [id, title, imgCover, price];
}
