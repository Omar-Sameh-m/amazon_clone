import 'package:amazon_clone/models/user_details_model.dart';
import 'package:amazon_clone/resources/cloud_firestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreMethods cloudFirestoreMethods = CloudFirestoreMethods();
  Future<String> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password,
  }) async {
    name = name.trim();
    address = address.trim();
    email = email.trim();
    password = password.trim();
    String output = 'Something went wrong';
    if (name != '' && address != '' && email != '' && password != '') {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserDetailsModel user = UserDetailsModel(address: address, name: name);
        await cloudFirestoreMethods.uploadNameAndAdressToDatabase(user: user);
        output = 'Success';
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = 'Please fill up everything';
    }
    return output;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    email = email.trim();
    password = password.trim();
    String output = 'Something went wrong';
    if (email != '' && password != '') {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        output = 'success';
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = 'Please fill up everything';
    }
    return output;
  }
}
