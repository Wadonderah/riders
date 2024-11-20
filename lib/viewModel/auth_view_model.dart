// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global_instances.dart';
import '../views/mainScreens/home_screen.dart';

class AuthViewModel {
  static const String usersCollection = "Users";
  static const String ridersImagesPath = "RidersImages";

  Future<void> validateSignUpForm(XFile? image,
      {required String name,
      required String email,
      required String password,
      required String confirmPassword,
      required BuildContext context,
      required String location,
      required String phone}) async {
    if (image == null) {
      showSnackBar("Please pick an image", context);
      return;
    }

    if (password != confirmPassword) {
      showSnackBar("Passwords don't match", context);
      return;
    }

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showSnackBar("Please fill all the fields", context);
      return;
    }

    User? currentFirebaseUser = await createUserInFirebaseAuth(email, password, context);

    if (currentFirebaseUser != null) {
      String downloadUrl = await uploadImageToFirebase(image);
      await saveDataToFirestore(currentFirebaseUser, name, email, downloadUrl, context);
      navigateToHome(context);
    }
    showSnackBar("Account created successfully", context);
  }

  Future<void> loginUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      showSnackBar("Sign in successful", context);
      navigateToHome(context);
    } catch (error) {
      showSnackBar(error.toString(), context);
    }
  }

  Future<User?> createUserInFirebaseAuth(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (error) {
      showSnackBar(error.toString(), context);
      return null;
    }
  }

  Future<String> uploadImageToFirebase(XFile? imageXFile) async {
    String downloadUrl = "";
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref().child(ridersImagesPath).child(fileName);

    try {
      firebase_storage.UploadTask uploadTask = storageRef.putFile(File(imageXFile!.path));
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
    } catch (error) {
      print('Error uploading image: $error');
    }

    return downloadUrl;
  }

  Future<void> saveDataToFirestore(User? currentFirebaseUser, String name, String email, String downloadUrl, BuildContext context) async {
    if (currentFirebaseUser != null) {
      try {
        await FirebaseFirestore.instance.collection(usersCollection).doc(currentFirebaseUser.uid).set({
          "sellerUID": currentFirebaseUser.uid,
          "sellerEmail": email,
          "sellerName": name,
          "image": downloadUrl,
          "status": "approved",
          "userCart": ["garbageValue"],
        });

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString("uid", currentFirebaseUser.uid);
        await sharedPreferences.setString("email", email);
        await sharedPreferences.setString("name", name);
        await sharedPreferences.setStringList("userCart", ["garbageValue"]);
      } catch (error) {
        showSnackBar("Error saving data: $error", context);
      }
    }
  }

  Future<void> validateSignInForm(String email, String password, BuildContext context) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      showSnackBar("Checking credentials....", context);

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        String uid = userCredential.user?.uid ?? '';
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(usersCollection).doc(uid).get();

        if (userDoc.exists && userDoc['status'] == 'approved') {
          showSnackBar("Sign in successful", context);
          bool stayLoggedIn = await showStayLoggedInDialog(context);
          await saveStayLoggedInPreference(stayLoggedIn);
          navigateToHome(context);
        } else {
          showSnackBar("Your account is not approved.", context);
          FirebaseAuth.instance.signOut();
        }
      } catch (error) {
        showSnackBar(error.toString(), context);
      }
    } else {
      showSnackBar("Password and Email required", context);
    }
  }

  Future<bool> showStayLoggedInDialog(BuildContext context) async {
    bool stayLoggedIn = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Stay Logged In"),
          content: const Text("Do you want to stay logged in?"),
          actions: [
            TextButton(
              onPressed: () {
                stayLoggedIn = false;
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                stayLoggedIn = true;
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
    return stayLoggedIn;
  }

  Future<void> saveStayLoggedInPreference(bool stayLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('stayLoggedIn', stayLoggedIn);
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
