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
        "aboutUs": MessageLookupByLibrary.simpleMessage("About us"),
        "addToCart": MessageLookupByLibrary.simpleMessage("Add to cart"),
        "addedToCart": MessageLookupByLibrary.simpleMessage("Added to cart!"),
        "allPricesIncludeTax":
            MessageLookupByLibrary.simpleMessage("All prices include tax"),
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account? "),
        "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
        "area": MessageLookupByLibrary.simpleMessage("Area"),
        "bestSeller": MessageLookupByLibrary.simpleMessage("Best seller"),
        "bouquetInclude":
            MessageLookupByLibrary.simpleMessage("Bouquet include"),
        "cartTitle": m0,
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "change": MessageLookupByLibrary.simpleMessage("change"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "codeIsRequired":
            MessageLookupByLibrary.simpleMessage("Code is required"),
        "codeVerificationDis": MessageLookupByLibrary.simpleMessage(
            "Please enter the verification code sent to your email address."),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmPassword": MessageLookupByLibrary.simpleMessage(
            "Please confirm your password"),
        "confirmPassword2":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "connectionTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please check your internet connection."),
        "continueAsGuest":
            MessageLookupByLibrary.simpleMessage("Continue as Guest"),
        "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
            "Could not open maps on this device"),
        "creatingAnAccountYouAgreeToOur": MessageLookupByLibrary.simpleMessage(
            "Creating an account, you agree to our"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "deliverTo": MessageLookupByLibrary.simpleMessage("Deliver to  "),
        "delivered": MessageLookupByLibrary.simpleMessage("Delivered"),
        "deliveryAddress":
            MessageLookupByLibrary.simpleMessage("Delivery address"),
        "deliveryFee": MessageLookupByLibrary.simpleMessage("Delivery Fee"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "didNotReceiveCode":
            MessageLookupByLibrary.simpleMessage("Didn\'t receive the code?"),
        "dontHaveAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "editProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
        "egp": MessageLookupByLibrary.simpleMessage("EGP"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailIsRequired":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "emailVerification":
            MessageLookupByLibrary.simpleMessage("Email Verification"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "enterEmailAssociatedToAccount": MessageLookupByLibrary.simpleMessage(
            "Please enter your email associated to your account"),
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
        "enterYourVerificationCode": MessageLookupByLibrary.simpleMessage(
            "Enter your verification code that sent to your email address"),
        "errorMessageGeneric": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Please try again."),
        "estimatedArrival":
            MessageLookupByLibrary.simpleMessage("Estimated arrival"),
        "female": MessageLookupByLibrary.simpleMessage("Female"),
        "firstName": MessageLookupByLibrary.simpleMessage("First name"),
        "firstNmae": MessageLookupByLibrary.simpleMessage("First name"),
        "florista": MessageLookupByLibrary.simpleMessage("Florista"),
        "flowery": MessageLookupByLibrary.simpleMessage("Flowery"),
        "forgetPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "gender": MessageLookupByLibrary.simpleMessage("Gender"),
        "inStock": MessageLookupByLibrary.simpleMessage("In stock"),
        "invalidCode": MessageLookupByLibrary.simpleMessage("Invalid code"),
        "isYourDeliveryHeroForToday": MessageLookupByLibrary.simpleMessage(
            "Is your delivery hero for today"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lastName": MessageLookupByLibrary.simpleMessage("Last name"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "male": MessageLookupByLibrary.simpleMessage("Male"),
        "mustBeAtLeast3Characters": MessageLookupByLibrary.simpleMessage(
            "Must be at least 3 characters"),
        "myOrders": MessageLookupByLibrary.simpleMessage("My orders"),
        "networkError": MessageLookupByLibrary.simpleMessage(
            "Network error. Please check your connection."),
        "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
        "noEmail": MessageLookupByLibrary.simpleMessage("No email"),
        "noName": MessageLookupByLibrary.simpleMessage("No name"),
        "noUserData": MessageLookupByLibrary.simpleMessage("No user data"),
        "noValueKeyFound":
            MessageLookupByLibrary.simpleMessage("No value found for key: "),
        "notFound": MessageLookupByLibrary.simpleMessage(
            "Requested resource not found."),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "occasion": MessageLookupByLibrary.simpleMessage("Occasion"),
        "onlyLettersAllowed":
            MessageLookupByLibrary.simpleMessage("Only letters allowed"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Open in Maps"),
        "outForDelivery":
            MessageLookupByLibrary.simpleMessage("Out for delivery"),
        "outOfStock": MessageLookupByLibrary.simpleMessage("Out of stock"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Password changed successfully!"),
        "passwordMustBeAtLeastCharacters": MessageLookupByLibrary.simpleMessage(
            "Password must not be empty and must contain at least 6 characters with upper case letter and one digit"),
        "paswordNotMatched":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone number"),
        "plusCode": MessageLookupByLibrary.simpleMessage("Plus Code"),
        "preparingYourOrder":
            MessageLookupByLibrary.simpleMessage("Preparing your order"),
        "productDetails":
            MessageLookupByLibrary.simpleMessage("Product Details"),
        "profileUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Profile updated successfully!"),
        "readMore": MessageLookupByLibrary.simpleMessage("Read more"),
        "receivedYourOrder":
            MessageLookupByLibrary.simpleMessage("Received your order"),
        "rememberMe": MessageLookupByLibrary.simpleMessage("Remember me"),
        "requestTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please try again."),
        "resend": MessageLookupByLibrary.simpleMessage("Resend"),
        "resendCode": MessageLookupByLibrary.simpleMessage("Resend"),
        "savedAddress": MessageLookupByLibrary.simpleMessage("Saved address"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "secureStorageErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Failed to save information securely. Please try again."),
        "serverError": MessageLookupByLibrary.simpleMessage(
            "Server error. Please try again later."),
        "showLess": MessageLookupByLibrary.simpleMessage("Show less"),
        "showMap": MessageLookupByLibrary.simpleMessage("Show map"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpSuccess":
            MessageLookupByLibrary.simpleMessage("Sign up success"),
        "somethineWentWrong": MessageLookupByLibrary.simpleMessage(
            "Something went wrong Try again later"),
        "splashTagline": MessageLookupByLibrary.simpleMessage(
            "Fresh flowers, delivered with love."),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "subTotal": MessageLookupByLibrary.simpleMessage("Sub Total"),
        "termsConditions":
            MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "trackOrder": MessageLookupByLibrary.simpleMessage("Track order"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
        "virson": MessageLookupByLibrary.simpleMessage("v 6.3.0 - (446)")
      };
}
