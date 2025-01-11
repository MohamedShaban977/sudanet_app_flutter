
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../app_manage/strings_manager.dart';
import 'my_regex_manager.dart';

class Validator {
  static String? isValidEmail(String email) {
    if (email.isEmpty) {
      return AppStrings.fieldIsRequired.tr();
    } else if (!MyRegex.rxEmail.hasMatch(email)) {
      return AppStrings.invalidEmailFormat.tr();
    } else {
      return null;
    }
  }

  static String? isValidUserName(String userName) {
    if (userName.isEmpty) {
      return AppStrings.fieldIsRequired.tr();
    } else {
      return null;
    }
  }

  static String? isValidPhone(String phone) {
    if (phone.isEmpty) {
      return AppStrings.fieldIsRequired.tr();
    } else if (!MyRegex.rxPhone.hasMatch(phone)) {
      return AppStrings.fieldIsRequired.tr();
    }
    else {
      return null;
    }
  }

  static String? isValidPassword(String password) {
    if (password.isEmpty) {
      return AppStrings.fieldIsRequired.tr();
    } else if (password.length < 6) {
      return AppStrings.invalidPassword.tr();
    } else {
      return null;
    }
  }

  static String? isValidConfirmPassword(String password,
      String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return AppStrings.fieldIsRequired.tr();
    } else if (confirmPassword.length < 6) {
      return AppStrings.invalidPassword.tr();
    } else if (password != confirmPassword) {
      return AppStrings.passwordDoesNotMatch.tr();
    } else {
      return null;
    }
  }


  static String? isValidCode(String code) {
    if (code.isEmpty) {
      return AppStrings.fieldIsRequired.tr();
    } else if (code.length < 6) {
      return AppStrings.fieldIsRequired.tr();
    }
    else {
      return null;
    }
  }
}
