import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/repo/login_repo.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/usecase/login_usecase.dart';

// ── Mock (mocktail — no code generation needed) ────────────────────────────
class MockLoginRepo extends Mock implements LoginRepo {}

void main() {
  late MockLoginRepo mockRepo;
  late LoginUseCase useCase;

  const email = 'user@example.com';
  const password = 'MyP@ssw0rd';
  const entity = LoginEntity(message: 'ok', token: 'jwt-abc');

  setUp(() {
    mockRepo = MockLoginRepo();
    useCase = LoginUseCase(mockRepo);
  });

  group('LoginUseCase', () {
    test('delegates to LoginRepo.login with the correct credentials', () async {
      when(
            () => mockRepo.login(email: email, password: password),
      ).thenAnswer((_) async => const SuccessBaseResponse(data: entity));

      await useCase(email: email, password: password);

      verify(() => mockRepo.login(email: email, password: password)).called(1);
    });

    test('returns SuccessBaseResponse from repo on success', () async {
      when(
            () => mockRepo.login(email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer((_) async => const SuccessBaseResponse(data: entity));

      final result = await useCase(email: email, password: password);

      expect(result, isA<SuccessBaseResponse<LoginEntity>>());
      expect((result as SuccessBaseResponse<LoginEntity>).data, entity);
    });

    test('returns ErrorBaseResponse from repo on failure', () async {
      when(
            () => mockRepo.login(email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer(
            (_) async => const ErrorBaseResponse(errorMessage: 'Invalid credentials'),
      );

      final result = await useCase(email: email, password: password);

      expect(result, isA<ErrorBaseResponse<LoginEntity>>());
      expect(
        (result as ErrorBaseResponse<LoginEntity>).errorMessage,
        'Invalid credentials',
      );
    });

    test('calls repo exactly once per invocation', () async {
      when(
            () => mockRepo.login(email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer((_) async => const SuccessBaseResponse(data: entity));

      await useCase(email: email, password: password);

      verify(
            () => mockRepo.login(email: any(named: 'email'), password: any(named: 'password')),
      ).called(1);
    });
  });
}