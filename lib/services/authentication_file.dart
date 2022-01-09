import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'db.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebase(User? user) {
    return user ?? null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signupWithMailAndPass(String mail, String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> loginWithMailAndPass(String mail, String pass) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /*Future deleteUser(String email, String password) async {
    try {
      User user = await _auth.currentUser();
      AuthCredential credentials =
      EmailAuthProvider.getCredential(email: email, password: password);
      print(user);
      AuthResult result = await user.reauthenticateWithCredential(credentials);
      await DBService(uid: result.user.uid).deleteuser(); // called from database class
      await result.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/



}

