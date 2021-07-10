
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';

class AuthenticationProvider with ChangeNotifier {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get userState => _firebaseAuth.authStateChanges();
  Stream<User?> get userIdTokenChange => _firebaseAuth.idTokenChanges();
  Stream<User?> get userChange => _firebaseAuth.userChanges();

  void register(
      {required String email,
        required String password,
        required String userName,
        required BuildContext context}) async {
    NavigationUtils.showLoadingDialog(context);
    try {
      UserCredential _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? _user = _userCredential.user;
      await FirebaseFirestore.instance.collection(Strings.usersCollection).doc(_user?.uid).set(
          {
           Strings.messageModelUserId: _user?.uid,
           Strings.userModelName: userName,
           Strings.userModelImagePath: _user?.photoURL
          }
           );
      NavigationUtils.hideDialog(context);
      NavigationUtils.showMyDialog(
          context: context, 
          bodyText: Strings.successRegister, 
          onClick: () => Navigator.pushNamedAndRemoveUntil(
            context,
            PAGE_SIGN_IN,
            ModalRoute.withName(PAGE_SIGN_IN),
          ));
    } on FirebaseAuthException catch (e) {
      NavigationUtils.hideDialog(context);
      if (e.code == 'weak-password') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorPasswordWeak);
      } else if (e.code == 'email-already-in-use') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorAccountAlreadyExists);
      }
    } catch (e) {
      print(e);
    }
  }

  void signIn({required String email, required String password, required BuildContext context}) async {
    NavigationUtils.showLoadingDialog(context);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        NavigationUtils.hideDialog(context);
        Navigator.pushNamed(context, PAGE_MESSAGES);
      });
    } on FirebaseAuthException catch (e) {
      NavigationUtils.hideDialog(context);
      if (e.code == 'user-not-found') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorNoUserForThisEmail);
      } else if (e.code == 'wrong-password') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorWrongPassword);
      } else if (e.code == 'user-disabled') {
        NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorUserDisabled);
      }
    }
  }

  void signOut(BuildContext context) async {
    NavigationUtils.showLoadingDialog(context);
    try {
      await _firebaseAuth.signOut().then((value) {
        NavigationUtils.hideDialog(context);
        Navigator.pushNamed(context, PAGE_SIGN_IN);
      });
    } catch(e){
      NavigationUtils.hideDialog(context);
      NavigationUtils.showMyDialog(context: context, bodyText: Strings.errorLogOut);
      print("erreur log out : $e");
    }
  }

  void reloadFirebase({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      User? _user = currentUser;
      if(_user == null) {
        showDisconnectDialog(context: context);
      }

    }  on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        showDisconnectDialog(context: context);
      }
    }
  }

  void showDisconnectDialog({required BuildContext context}) {
    NavigationUtils.showMyDialog(
        context: context,
        bodyText: Strings.errorUserNotFound,
        onClick: () => signOut(context)
    );
  }

}