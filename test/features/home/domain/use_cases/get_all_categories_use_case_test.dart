import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_all_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final GetAllCategoriesUseCase useCase;

  setUp(() async {
    await configureDependencies();
    useCase = getIt.get<GetAllCategoriesUseCase>();
  });
  test('Test GetAllCategories', () async {
    final categories = useCase.call();
    switch (categories) {
      case SuccessBaseResponse<List<CategoryEntity>>():
        expect(categories, isA<SuccessBaseResponse<List<CategoryEntity>>>());
        break;
      case ErrorBaseResponse<List<CategoryEntity>>():
        expect(categories, isA<ErrorBaseResponse<List<CategoryEntity>>>());
        break;
    }
  });
}
