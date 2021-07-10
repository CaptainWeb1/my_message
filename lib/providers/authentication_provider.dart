
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';

class AuthenticationProvider with ChangeNotifier {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get userState => _firebaseAuth.authStateChanges();
  Stream<User?> get userIdTokenChange => _firebaseAuth.idTokenChanges();
  Stream<User?> get userChange => _firebaseAuth.userChanges();
  
  void signUp({
    required String email,
    required String password,
    required String userName,
    required BuildContext context
  }) async {
    NavigationUtils.showLoadingDialog(context);
    try {
      UserCredential _userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      NavigationUtils.hideDialog(context);
      NavigationUtils.showMyDialog(
          context: context,
          bodyText: Strings.successRegister,
          onClick: () => Navigator.pushNamedAndRemoveUntil(
              context,
              PAGE_SIGN_IN,
              ModalRoute.withName(PAGE_SIGN_IN)
          )
      );
    } on FirebaseAuthException catch (e) {
      NavigationUtils.hideDialog(context);
      if(e.code == 'weak-password') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorPasswordLength);
      } else if (e.code == 'email-already-in-use'){
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorAccountAlreadyExists);
      } else {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorAuthSignUp);
      }
    }
  }
  
  void signIn() {
    
  }
  
  void signOut() {
    
  }

}