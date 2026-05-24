import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'locale_states.dart';

@Singleton()
class LocaleCubit extends Cubit<LocaleState> {
  final SecureStorageService _secureStorageService;

  static const String _kLocaleKey = 'app_locale';

  LocaleCubit(this._secureStorageService)
    : super(const LocaleState(Locale('en')));

  Future<void> getSavedLanguage() async {
    final BaseResponse<String> response = await _secureStorageService.read(
      key: _kLocaleKey,
    );

    if (response is SuccessBaseResponse<String>) {
      emit(LocaleState(Locale(response.data)));
    } else {
      emit(const LocaleState(Locale('en')));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    final BaseResponse<String> response = await _secureStorageService.write(
      key: _kLocaleKey,
      value: languageCode,
    );

    if (response is SuccessBaseResponse<String>) {
      emit(LocaleState(Locale(languageCode)));
    }
  }
}
