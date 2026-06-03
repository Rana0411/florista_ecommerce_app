import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_all_best_seller_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final GetAllBestSellerUseCase useCase;

  setUp(() async {
    await configureDependencies();
    useCase = getIt.get<GetAllBestSellerUseCase>();
  });
  test('Test GetAllBestSeller', () async {
    final bestSeller = await useCase.call();
    switch (bestSeller) {
      case SuccessBaseResponse<List<BestSellerEntity>>():
        expect(bestSeller, isA<SuccessBaseResponse<List<BestSellerEntity>>>());
        break;
      case ErrorBaseResponse<List<BestSellerEntity>>():
        expect(bestSeller, isA<ErrorBaseResponse<List<BestSellerEntity>>>());
        break;
    }
  });
}
