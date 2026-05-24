import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Reloads [S] when the app locale changes (generated delegate sets shouldReload to false).
class FloristaLocalizationDelegate extends LocalizationsDelegate<S> {
  const FloristaLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => S.delegate.isSupported(locale);

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<S> old) => true;
}
