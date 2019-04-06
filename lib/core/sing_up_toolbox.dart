class SignUpToolbox {

  static String getErrorMessageOfErrorCode(String code){
    switch(code){
      case "ERROR_EMAIL_ALREADY_IN_USE": return "The email address is already in use by another account";
      case "ERROR_WRONG_PASSWORD": return "Wrong password";
      case "ERROR_USER_NOT_FOUND": return "Email not taken by an account";
      case "ERROR_TOO_MANY_REQUESTS": return "Too many requests, try again";
      default: {
        print("Unknown firebase-error-code: $code");
        return "An error occoured, please check your inputs";
      }
    }
  }
}