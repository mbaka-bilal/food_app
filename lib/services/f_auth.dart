import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/features/dashboard/screens/dashboard_screen.dart';

import '../features/onboarding/login/screens/login_screen.dart';
import '../widgets/status_screen.dart';
import '/helpers/error_message.dart';
import '/helpers/request_status.dart';
import 'f_database.dart';

class FAuth extends ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  RequestStatus _requestStatus = RequestStatus(status: Status.loading);

  RequestStatus showRequestStatus() {
    return _requestStatus;
  }

  void createUser(String name,String email, String password,String phoneNumber, BuildContext context) async {
    _requestStatus = RequestStatus(status: Status.loading);
    notifyListeners();
    try {
      final nav = Navigator.of(context);
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FDatabase.addUser(name, phoneNumber);
      // await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      await firebaseAuth.signOut();
      _requestStatus = RequestStatus(
          status: Status.success,
          message: 'Click on link sent to email to validate account');
      //remove the alert dialog
      nav.pushReplacement(MaterialPageRoute(
          builder: (context) => StatusScreen(
                status: Status.success,
                headerText: 'Sign up Successfull',
                subText: _requestStatus.message!,
                function: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen())),
              )));
    } on FirebaseAuthException catch (e) {
      print("error signin up  ${e.code}");
      _requestStatus = RequestStatus(
          status: Status.failure, message: ErrorMessages.mapError(e.code));
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StatusScreen(
                status: Status.failure,
                headerText: 'Sign up unsuccessful',
                subText: _requestStatus.message!,
                function: () => Navigator.of(context).pop(),
              )));
    }
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    _requestStatus = RequestStatus(status: Status.loading);
    notifyListeners();
    try {
      final nav = Navigator.of(context);
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // if (firebaseAuth.currentUser!.emailVerified) {
        _requestStatus =
            RequestStatus(status: Status.success, message: 'Welcome back');
        //remove the alert dialog
        nav.pushReplacement(MaterialPageRoute(
            builder: (context) => StatusScreen(
                  status: Status.success,
                  headerText: 'Login successful',
                  subText: _requestStatus.message!,
                  function: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const DashBoardScreen())),
                )));
      // } else {
      //   nav.pop();
      //
      //   throw UserNotVerifiedException();
      // }
    } on FirebaseAuthException catch (e) {
      print("error signing in  ${e.code}");
      _requestStatus = RequestStatus(
          status: Status.failure, message: ErrorMessages.mapError(e.code));
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StatusScreen(
                status: Status.failure,
                headerText: 'Sign in Unsuccessful',
                subText: _requestStatus.message!,
                function: () => Navigator.of(context).pop(),
              )));
    } on UserNotVerifiedException catch (e) {
      print("user is not verified");
      _requestStatus = RequestStatus(
          status: Status.failure,
          message: ErrorMessages.mapError('user-not-verified'));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StatusScreen(
                status: Status.failure,
                headerText: 'Sign in Unsuccessful',
                subText: _requestStatus.message!,
                function: () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  try {

                    await firebaseAuth.currentUser!.sendEmailVerification();
                    scaffoldMessenger.showSnackBar(const SnackBar(
                      content: Text('Successfully sent verification Link'),
                    ));
                  } catch (e) {}
                },
              )));
    }
  }

   bool isLoggedIn()  {
    if (FirebaseAuth.instance.currentUser != null){
      print ("user exists");
      return true;
    }else{
      print ("user does not exists");
      return false;
    }
  }

  void forgotPassword(String email,BuildContext context) async {
    _requestStatus = RequestStatus(status: Status.loading);
    notifyListeners();
    try {
      final nav = Navigator.of(context);
      await firebaseAuth.sendPasswordResetEmail(email: email);

      _requestStatus = RequestStatus(
          status: Status.success,
          message: 'Click on link sent email to reset password');
      //remove the alert dialog
      nav.pushReplacement(MaterialPageRoute(
          builder: (context) => StatusScreen(
            status: Status.success,
            headerText: 'Email sent successfully',
            subText: _requestStatus.message!,
            function: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const LoginScreen())),
          )));
    } on FirebaseAuthException catch (e) {
      print("error resetting password  ${e.code}");
      _requestStatus = RequestStatus(
          status: Status.failure, message: ErrorMessages.mapError(e.code));
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StatusScreen(
            status: Status.failure,
            headerText: 'Could not send reset link',
            subText: _requestStatus.message!,
            function: () => Navigator.of(context).pop(),
          )));
    }
  }

   void logOut(BuildContext context) {
    firebaseAuth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
}


class UserNotVerifiedException implements Exception {}
