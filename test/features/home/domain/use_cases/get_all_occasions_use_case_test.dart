import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/occasion_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_all_occasions_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final GetAllOccasionsUseCase useCase;

  setUp(() async {
    await configureDependencies();
    useCase = getIt.get<GetAllOccasionsUseCase>();
  });
  test('Test GetAllOccasions', () async {
    final occasions = await useCase.call();
    switch (occasions) {
      case SuccessBaseResponse<List<OccasionEntity>>():
        expect(occasions, isA<SuccessBaseResponse<List<OccasionEntity>>>());
        break;
      case ErrorBaseResponse<List<OccasionEntity>>():
        expect(occasions, isA<ErrorBaseResponse<List<OccasionEntity>>>());
        break;
    }
  });
}
