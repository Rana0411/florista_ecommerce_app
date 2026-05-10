// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "codeVerificationDis": MessageLookupByLibrary.simpleMessage(
            "Please enter the verification code sent to your email address."),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "connectionTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please check your internet connection."),
        "didNotReceiveCode":
            MessageLookupByLibrary.simpleMessage("Didn\'t receive the code?"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailVerification":
            MessageLookupByLibrary.simpleMessage("Email Verification"),
        "enterEmailAssociatedToAccount": MessageLookupByLibrary.simpleMessage(
            "Please enter your email associated to your account"),
        "enterYourEmail":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "enterYourVerificationCode": MessageLookupByLibrary.simpleMessage(
            "Enter your verification code that sent to your email address"),
        "errorMessageGeneric": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Please try again."),
        "forgetPassword":
            MessageLookupByLibrary.simpleMessage("Forget Password"),
        "networkError": MessageLookupByLibrary.simpleMessage(
            "Network error. Please check your connection."),
        "noValueKeyFound":
            MessageLookupByLibrary.simpleMessage("No value found for key: "),
        "notFound": MessageLookupByLibrary.simpleMessage(
            "Requested resource not found."),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMustBeAtLeastCharacters": MessageLookupByLibrary.simpleMessage(
            "Password must not be empty and must contain at least 6 characters with upper case letter and one digit"),
        "requestTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please try again."),
        "resend": MessageLookupByLibrary.simpleMessage("Resend"),
        "resendCode": MessageLookupByLibrary.simpleMessage("Resend"),
        "secureStorageErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Failed to save information securely. Please try again."),
        "serverError": MessageLookupByLibrary.simpleMessage(
            "Server error. Please try again later.")
      };
}
