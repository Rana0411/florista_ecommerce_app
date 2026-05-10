// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get connectionTimeout => 'Request timed out. Please check your internet connection.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get notFound => 'Requested resource not found.';

  @override
  String get errorMessageGeneric => 'Something went wrong. Please try again.';

  @override
  String get networkError => 'Network error. Please check your connection.';

  @override
  String get requestTimeout => 'Request timed out. Please try again.';

  @override
  String get secureStorageErrorMessage => 'Failed to save information securely. Please try again.';

  @override
  String get noValueKeyFound => 'No value found for key: ';
}
