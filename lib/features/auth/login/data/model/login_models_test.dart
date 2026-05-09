import 'package:flutter_test/flutter_test.dart';
import 'package:florista_ecommerce_app/core/app_keys/api_keys.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_request_model.dart';
import 'package:florista_ecommerce_app/features/auth/login/data/model/login_response_model.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';

void main() {
  // ── LoginRequestModel ────────────────────────────────────────────────────
  group('LoginRequestModel', () {
    const email = 'user@example.com';
    const password = 'MyP@ssw0rd';
    const model = LoginRequestModel(email: email, password: password);

    test('stores email and password correctly', () {
      expect(model.email, email);
      expect(model.password, password);
    });

    group('toJson', () {
      test('produces a map with the correct keys', () {
        final json = model.toJson();
        expect(json.containsKey(ApiKeys.email), isTrue);
        expect(json.containsKey(ApiKeys.password), isTrue);
      });

      test('produces correct values for email and password', () {
        final json = model.toJson();
        expect(json[ApiKeys.email], email);
        expect(json[ApiKeys.password], password);
      });

      test('map contains exactly 2 entries', () {
        expect(model.toJson().length, 2);
      });
    });
  });

  // ── LoginResponseModel ───────────────────────────────────────────────────
  group('LoginResponseModel', () {
    const sampleJson = {
      ApiKeys.message: 'Login successful',
      ApiKeys.token: 'jwt-token-abc123',
    };

    group('fromJson', () {
      test('parses message correctly', () {
        final model = LoginResponseModel.fromJson(sampleJson);
        expect(model.message, 'Login successful');
      });

      test('parses token correctly', () {
        final model = LoginResponseModel.fromJson(sampleJson);
        expect(model.token, 'jwt-token-abc123');
      });

      test('handles null message gracefully', () {
        final model = LoginResponseModel.fromJson({ApiKeys.token: 'tok'});
        expect(model.message, isNull);
        expect(model.token, 'tok');
      });

      test('handles null token gracefully', () {
        final model =
        LoginResponseModel.fromJson({ApiKeys.message: 'msg'});
        expect(model.token, isNull);
        expect(model.message, 'msg');
      });

      test('handles completely empty json', () {
        final model = LoginResponseModel.fromJson({});
        expect(model.message, isNull);
        expect(model.token, isNull);
      });
    });

    group('toEntity', () {
      test('converts to LoginEntity with matching fields', () {
        final model = LoginResponseModel.fromJson(sampleJson);
        final entity = model.toEntity();

        expect(entity, isA<LoginEntity>());
        expect(entity.message, model.message);
        expect(entity.token, model.token);
      });

      test('null fields are preserved in entity', () {
        const model = LoginResponseModel(message: null, token: null);
        final entity = model.toEntity();

        expect(entity.message, isNull);
        expect(entity.token, isNull);
      });
    });
  });

  // ── LoginEntity ──────────────────────────────────────────────────────────
  group('LoginEntity', () {
    test('stores message and token', () {
      const entity = LoginEntity(message: 'ok', token: 'tok');
      expect(entity.message, 'ok');
      expect(entity.token, 'tok');
    });

    test('two entities with the same values are equal (Equatable)', () {
      const a = LoginEntity(message: 'ok', token: 'tok');
      const b = LoginEntity(message: 'ok', token: 'tok');
      expect(a, equals(b));
    });

    test('two entities with different tokens are not equal', () {
      const a = LoginEntity(token: 'token-a');
      const b = LoginEntity(token: 'token-b');
      expect(a, isNot(equals(b)));
    });

    test('props contains message and token', () {
      const entity = LoginEntity(message: 'msg', token: 'tok');
      expect(entity.props, ['msg', 'tok']);
    });
  });
}
