import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  Future checkIfEmailIsPresent({
    required String email,
  }) async {
    List elements = [];
    await userCollection
        .where(
          "email",
          isEqualTo: email,
        )
        .get()
        .then(
      (querySnapshot) {
        querySnapshot.docs.map((element) {
          if (element.data().isNotEmpty) {
            elements.add(element.data());
          }
        });
      },
    );
    return elements.isNotEmpty;
  }

  Future checkIfPhoneNumberIsPresent({
    required String phoneNumber,
  }) async {
    List elements = [];

    await userCollection
        .where(
          "phone number",
          isEqualTo: phoneNumber,
        )
        .get()
        .then(
      (querySnapshot) {
        querySnapshot.docs.map((element) {
          if (element.data().isNotEmpty) {
            elements.add(element.data());
          }
        });
      },
    );
    return elements.isNotEmpty;
  }

  Future<User> createAccount({
    required String email,
    required String password,
    required String phoneNumber,
    required PhoneAuthCredential phoneCredentials,
  }) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        user.linkWithPhoneNumber(phoneNumber);
        user.linkWithCredential(phoneCredentials);

        return user;
      } else {
        throw 'Some Error has Occurred';
      }
    } on PlatformException catch (error) {
      throw error.message!;
    }
  }

  Future<User> signInWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        throw 'Some Error has Occurred';
      }
    } on PlatformException catch (error) {
      throw error.message!;
    }
  }

  Future<User?> signInWithPhone({
    required String email,
  }) async {
    return null;
  }
}
