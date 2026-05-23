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

  static String m0(count) =>
      "Cart (${Intl.plural(count, zero: 'Empty', one: '1 item', other: '${count} items')})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "EGB": MessageLookupByLibrary.simpleMessage("EGB"),
        "addToCart": MessageLookupByLibrary.simpleMessage("Add to cart"),
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "area": MessageLookupByLibrary.simpleMessage("Area"),
        "cartTitle": m0,
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "codeIsRequired":
            MessageLookupByLibrary.simpleMessage("Code is required"),
        "confirmPassword": MessageLookupByLibrary.simpleMessage(
            "Please confirm your password"),
        "connectionTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please check your internet connection."),
        "continueAsGuest":
            MessageLookupByLibrary.simpleMessage("Continue as Guest"),
        "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
            "Could not open maps on this device"),
        "creatingAnAccountYouAgreeToOur": MessageLookupByLibrary.simpleMessage(
            "Creating an account, you agree to our"),
        "deliverTo": MessageLookupByLibrary.simpleMessage("Deliver to  "),
        "deliveryAddress":
            MessageLookupByLibrary.simpleMessage("Delivery address"),
        "dontHaveAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailIsRequired":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "enterFirstName":
            MessageLookupByLibrary.simpleMessage("Enter first name"),
        "enterLastName":
            MessageLookupByLibrary.simpleMessage("Enter last name"),
        "enterPassword": MessageLookupByLibrary.simpleMessage("Enter Password"),
        "enterPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Enter phone number"),
        "enterValidEgyptianPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Enter a valid Egyptian phone number"),
        "enterValidEmail":
            MessageLookupByLibrary.simpleMessage("Enter a valid email address"),
        "enterValidPassword": MessageLookupByLibrary.simpleMessage(
            "Password needs uppercase, digit, and special char"),
        "enterYourEmail":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "errorMessageGeneric": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Please try again."),
        "female": MessageLookupByLibrary.simpleMessage("Female"),
        "firstName": MessageLookupByLibrary.simpleMessage("First name"),
        "florista": MessageLookupByLibrary.simpleMessage("Florista"),
        "forgetPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "gender": MessageLookupByLibrary.simpleMessage("Gender"),
        "invalidCode": MessageLookupByLibrary.simpleMessage("Invalid code"),
        "lastName": MessageLookupByLibrary.simpleMessage("Last name"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "male": MessageLookupByLibrary.simpleMessage("Male"),
        "mustBeAtLeast3Characters": MessageLookupByLibrary.simpleMessage(
            "Must be at least 3 characters"),
        "networkError": MessageLookupByLibrary.simpleMessage(
            "Network error. Please check your connection."),
        "noValueKeyFound":
            MessageLookupByLibrary.simpleMessage("No value found for key: "),
        "notFound": MessageLookupByLibrary.simpleMessage(
            "Requested resource not found."),
        "onlyLettersAllowed":
            MessageLookupByLibrary.simpleMessage("Only letters allowed"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Open in Maps"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "paswordNotMatched":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone number"),
        "plusCode": MessageLookupByLibrary.simpleMessage("Plus Code"),
        "rememberMe": MessageLookupByLibrary.simpleMessage("Remember me"),
        "requestTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please try again."),
        "secureStorageErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Failed to save information securely. Please try again."),
        "serverError": MessageLookupByLibrary.simpleMessage(
            "Server error. Please try again later."),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpSuccess":
            MessageLookupByLibrary.simpleMessage("Sign up success"),
        "somethineWentWrong": MessageLookupByLibrary.simpleMessage(
            "Something went wrong Try again later"),
        "splashTagline": MessageLookupByLibrary.simpleMessage(
            "Fresh flowers, delivered with love."),
        "termsConditions":
            MessageLookupByLibrary.simpleMessage("Terms & Conditions")
      };
}
