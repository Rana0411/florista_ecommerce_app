import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_logged_user_addresses_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final GetLoggedUserAddressesUseCase useCase;

  setUp(() async {
    await configureDependencies();
    useCase = getIt.get<GetLoggedUserAddressesUseCase>();
  });
  test('Test GetLoggedUserAddresses', () async {
    final addresses = await useCase.call(
      token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjlmYzlkZDk2YmJhZjE1ODhiYmRkMjQxIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3Nzg1NDQzNDF9.pjmD32_XEa5D8ZwABCb0uZUjGzoCNJBN4fGywrWpo4c',
    );
    switch (addresses) {
      case SuccessBaseResponse<List<AddressEntity>>():
        expect(addresses, isA<SuccessBaseResponse<List<AddressEntity>>>());
        break;
      case ErrorBaseResponse<List<AddressEntity>>():
        expect(addresses, isA<ErrorBaseResponse<List<AddressEntity>>>());
        break;
    }
  });
}
