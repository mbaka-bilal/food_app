class ErrorMessages {
  static String mapError(String error) {
    switch (error) {
      case 'weak-password':
        return 'Password too weak';
      case 'email-already-in-use':
        return 'User already exists';
        case 'invalid-credential':
          return 'Invalid user';
      case 'invalid-email':
        return 'invalid email';
      case 'invalid-password':
        return 'invalid password';
      case 'network-request-failed':
        return 'No network, please check your internet connection';
      case 'wrong-password':
        return 'Incorrect email / Password';
      case 'user-not-found':
        return 'Incorrect email / Password';
      case 'user-not-verified':
        return 'please verify email';
      default:
        return 'unknown error';
    }
  }
}
