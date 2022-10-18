import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_penghuni_kos/menu.dart';
import 'package:data_penghuni_kos/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
//Dependencies
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User get user => _auth.currentUser!;

//Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Menu();
          } else {
            return const LoginPage();
          }
        });
  }
  
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User? user = userCredential.user;

    if (user != null) {
      if (userCredential.additionalUserInfo!.isNewUser) {
        // add to firebase
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'uid': user.uid,
          'email': user.email,
          'profilePhoto': user.photoURL,
          'noHP': 'Masukkan No HP'
        });
      }
      return true;
    } else {
      return false;
    }
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

}