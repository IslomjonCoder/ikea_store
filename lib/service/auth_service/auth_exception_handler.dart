class AuthExceptionHandler {
  static String handleException(e) {
    print(e);
    String errorMessage;
    switch (e) {
      case "invalid-credential":
        errorMessage = "The provider's credential is not valid. Please try again.";
        break;
      case "invalid-email":
        errorMessage = "Invalid email address. Please check the email and try again.";
        break;
      case "wrong-password":
        errorMessage = "Invalid password. Please check your password and try again.";
        break;
      case "user-not-found":
        errorMessage =
            "User not found. Please check your email and try again or sign up for a new account.";
        break;
      case "user-disabled":
        errorMessage = "User account has been disabled. Please contact support for assistance.";
        break;
      case "operation-not-allowed":
        errorMessage = "Operation not allowed. Please contact support for assistance.";
        break;
      case "too-many-requests":
        errorMessage = "Too many requests. Please try again later.";
        break;
      case "email-already-in-use":
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      case "weak-password":
        errorMessage = "The password is too weak. Please choose a stronger password.";
        break;
      case "invalid-verification-code":
        errorMessage = "Invalid verification code. Please check the code and try again.";
        break;
      case "invalid-verification-id":
        errorMessage = "Invalid verification ID. Please try again.";
        break;
      case "user-mismatch":
        errorMessage = "The credential provided does not correspond to your user.";
        break;
      case "provider-already-linked":
        errorMessage = "This sign-in method is already linked to your account.";
        break;
      case "channel-error":
        errorMessage = "Given String is empty or null";
        break;
      default:
        errorMessage = "An undefined error happened.";
      // errorMessage = e;
    }
    return errorMessage;
  }
}
//   static AuthResultStatus handleException(e) {
//     print(e.code);
//     AuthResultStatus status;
//     switch (e.code) {
//       case "invalid-credential":
//         status = AuthResultStatus.invalidCredential;
//         break;
//       case "invalid-email":
//         status = AuthResultStatus.invalidEmail;
//         break;
//       case "wrong-password":
//         status = AuthResultStatus.wrongPassword;
//         break;
//       case "user-not-found":
//         status = AuthResultStatus.userNotFound;
//         break;
//       case "user-disabled":
//         status = AuthResultStatus.userDisabled;
//         break;
//       case "operation-not-allowed":
//         status = AuthResultStatus.operationNotAllowed;
//         break;
//       case "too-many-requests":
//         status = AuthResultStatus.tooManyRequests;
//         break;
//       case "email-already-in-use":
//         status = AuthResultStatus.emailAlreadyExists;
//         break;
//       case "weak-password":
//         status = AuthResultStatus.weakPassword;
//         break;
//       case "invalid-verification-code":
//         status = AuthResultStatus.invalidVerificationCode;
//         break;
//       case "invalid-verification-id":
//         status = AuthResultStatus.invalidVerificationId;
//         break;
//       case "user-mismatch":
//         status = AuthResultStatus.userMismatch;
//         break;
//       case "provider-already-linked":
//         status = AuthResultStatus.providerAlreadyLinked;
//         break;
//       case "channel-error":
//         status = AuthResultStatus.networkError;
//         break;
//
//       default:
//         status = AuthResultStatus.undefined;
//     }
//     return status;
//   }
//
//   static String generateExceptionMessage(exceptionCode) {
//     print(exceptionCode);
//     String errorMessage;
//     switch (exceptionCode) {
//       // Common authentication errors
//       case AuthResultStatus.invalidCredential:
//         errorMessage =
//             "The provider's credential is not valid. Please try again.";
//         break;
//       case AuthResultStatus.invalidEmail:
//         errorMessage =
//             "Invalid email address. Please check the email and try again.";
//         break;
//       case AuthResultStatus.wrongPassword:
//         errorMessage =
//             "Invalid password. Please check your password and try again.";
//         break;
//       case AuthResultStatus.userNotFound:
//         errorMessage =
//             "User not found. Please check your email and try again or sign up for a new account.";
//         break;
//       case AuthResultStatus.userDisabled:
//         errorMessage =
//             "User account has been disabled. Please contact support for assistance.";
//         break;
//       case AuthResultStatus.operationNotAllowed:
//         errorMessage =
//             "Operation not allowed. Please contact support for assistance.";
//         break;
//       case AuthResultStatus.tooManyRequests:
//         errorMessage = "Too many requests. Please try again later.";
//         break;
//       case AuthResultStatus.emailAlreadyExists:
//         errorMessage =
//             "The email has already been registered. Please login or reset your password.";
//         break;
//       case AuthResultStatus.weakPassword:
//         errorMessage =
//             "The password is too weak. Please choose a stronger password.";
//         break;
//       case AuthResultStatus.invalidVerificationCode:
//         errorMessage =
//             "Invalid verification code. Please check the code and try again.";
//         break;
//       case AuthResultStatus.invalidVerificationId:
//         errorMessage = "Invalid verification ID. Please try again.";
//         break;
//
//       case AuthResultStatus.userMismatch:
//         errorMessage =
//             "The credential provided does not correspond to your user.";
//         break;
//       case AuthResultStatus.userNotFoundForCredential:
//         errorMessage =
//             "The credential provided does not correspond to any existing user.";
//         break;
//
//       case AuthResultStatus.providerAlreadyLinked:
//         errorMessage = "This sign-in method is already linked to your account.";
//         break;
//       case AuthResultStatus.networkError:
//         errorMessage = "Lost internet connection";
//         break;
//
//       default:
//         errorMessage = "An undefined error happened.";
//     }
//
//     return errorMessage;
//   }
// }
//
// enum AuthResultStatus {
//   successful,
//   emailAlreadyExists,
//   wrongPassword,
//   invalidEmail,
//   userNotFound,
//   userDisabled,
//   operationNotAllowed,
//   tooManyRequests,
//   undefined,
//   weakPassword,
//   invalidVerificationCode,
//   invalidVerificationId,
//   userMismatch,
//   userNotFoundForCredential,
//   invalidCredential,
//   providerAlreadyLinked,
//   networkError,
// }
