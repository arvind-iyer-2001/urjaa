import 'package:email_validator/email_validator.dart';
import 'package:password_strength/password_strength.dart';
import 'package:urjaa/backend/authentication/authentication_service.dart';

class RegistrationFormValidators {
  Future<bool> emailValidator(
    String email,
  ) async {
    if (email.isEmpty) {
      throw 'Email Field is Required';
    }
    bool emailExists =
        await AuthenticationService().checkIfEmailIsPresent(email: email);
    if (!emailExists) {
      bool validEmail = EmailValidator.validate(email);
      if (!validEmail) {
        throw 'Enter a Valid Email Address';
      }
      return true;
    }

    throw 'This Email is already Present!';
  }

  Future<bool> phoneValidator(
    String phoneNumber,
  ) async {
    try {
      if (phoneNumber.isEmpty) {
        throw 'Phone Number Field is Required';
      }
      if (phoneNumber.length < 7) {
        throw 'Enter a Valid Phone Number';
      }

      bool phoneNumberExists = await AuthenticationService()
          .checkIfPhoneNumberIsPresent(phoneNumber: phoneNumber);
      if (!phoneNumberExists) {
        return true;
      }
      throw 'This Phone Number is already Present!';
    } catch (e) {
      print(e.toString());
      throw 'Enter a Valid Phone Number';
    }
  }

  Future<bool> passwordValidator(
    String password,
    String confirmedPassword,
  ) async {
    if (estimatePasswordStrength(password) < 0.4) {
      throw 'Password is not Strong';
    }
    if (password != confirmedPassword) {
      throw 'Passwords don\'t match';
    }
    return true;
  }
}
