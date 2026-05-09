import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/data_source/login_local_data_source.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_request_model.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_response_model.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/repo/login_repo_impl.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';

// ── Mocks (mocktail — no code generation needed) ──────────────────────────
class MockLoginRemoteDataSource extends Mock implements LoginRemoteDataSource {}
class MockLoginLocalDataSource extends Mock implements LoginLocalDataSource {}

void main() {
  late MockLoginRemoteDataSource mockRemote;
  late MockLoginLocalDataSource mockLocal;
  late LoginRepoImpl repo;

  const email = 'user@example.com';
  const password = 'MyP@ssw0rd';

  // Register fallback values for any() matchers on custom types
  setUpAll(() {
    registerFallbackValue(
      const LoginRequestModel(email: 'fallback@example.com', password: 'Fallback1!'),
    );
  });

  setUp(() {
    mockRemote = MockLoginRemoteDataSource();
    mockLocal = MockLoginLocalDataSource();
    repo = LoginRepoImpl(mockRemote, mockLocal);
  });

  // ── Helpers ──────────────────────────────────────────────────────────────
  void stubRemoteSuccess({String token = 'jwt-token', String message = 'ok'}) {
    final model = LoginResponseModel(message: message, token: token);
    when(() => mockRemote.login(any()))
        .thenAnswer((_) async => SuccessBaseResponse(data: model));
    when(() => mockLocal.persistToken(any())).thenAnswer((_) async {});
  }

  void stubRemoteError({String errorMessage = 'Network error'}) {
    when(() => mockRemote.login(any())).thenAnswer(
          (_) async => ErrorBaseResponse(errorMessage: errorMessage),
    );
  }

  // ── Success path ─────────────────────────────────────────────────────────
  group('login – success', () {
    test('returns SuccessBaseResponse containing a LoginEntity', () async {
      stubRemoteSuccess(token: 'jwt-token', message: 'Login successful');

      final result = await repo.login(email: email, password: password);

      expect(result, isA<SuccessBaseResponse<LoginEntity>>());
    });

    test('entity has the correct token', () async {
      stubRemoteSuccess(token: 'my-token');

      final result =
      await repo.login(email: email, password: password)
      as SuccessBaseResponse<LoginEntity>;

      expect(result.data.token, 'my-token');
    });

    test('entity has the correct message', () async {
      stubRemoteSuccess(message: 'Welcome!');

      final result =
      await repo.login(email: email, password: password)
      as SuccessBaseResponse<LoginEntity>;

      expect(result.data.message, 'Welcome!');
    });

    test('calls persistToken with the token from the response', () async {
      stubRemoteSuccess(token: 'persisted-token');

      await repo.login(email: email, password: password);

      verify(() => mockLocal.persistToken('persisted-token')).called(1);
    });

    test('passes the correct email and password to remote data source',
            () async {
          stubRemoteSuccess();

          await repo.login(email: email, password: password);

          final captured = verify(() => mockRemote.login(captureAny()))
              .captured
              .single as LoginRequestModel;

          expect(captured.email, email);
          expect(captured.password, password);
        });
  });

  // ── Null token path ───────────────────────────────────────────────────────
  group('login – success with null token', () {
    setUp(() {
      final model = LoginResponseModel(message: 'ok', token: null);
      when(() => mockRemote.login(any()))
          .thenAnswer((_) async => SuccessBaseResponse(data: model));
    });

    test('does NOT call persistToken when token is null', () async {
      await repo.login(email: email, password: password);

      verifyNever(() => mockLocal.persistToken(any()));
    });

    test('still returns SuccessBaseResponse without a token', () async {
      final result = await repo.login(email: email, password: password);

      expect(result, isA<SuccessBaseResponse<LoginEntity>>());
    });
  });

  // ── Error path ────────────────────────────────────────────────────────────
  group('login – error', () {
    test('returns ErrorBaseResponse when remote fails', () async {
      stubRemoteError(errorMessage: 'Unauthorized');

      final result = await repo.login(email: email, password: password);

      expect(result, isA<ErrorBaseResponse<LoginEntity>>());
    });

    test('propagates the errorMessage from remote', () async {
      stubRemoteError(errorMessage: 'Unauthorized');

      final result =
      await repo.login(email: email, password: password)
      as ErrorBaseResponse<LoginEntity>;

      expect(result.errorMessage, 'Unauthorized');
    });

    test('does NOT call persistToken on error', () async {
      stubRemoteError();

      await repo.login(email: email, password: password);

      verifyNever(() => mockLocal.persistToken(any()));
    });
  });
}