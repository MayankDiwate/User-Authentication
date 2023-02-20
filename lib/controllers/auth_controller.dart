import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth/constants.dart';
import 'package:user_auth/controllers/user_controller.dart';
import 'package:user_auth/models/user_model.dart';
import 'package:user_auth/screens/home_screen.dart';
import 'package:user_auth/screens/login_screen.dart';

class AuthController extends GetxController {
  //AuthController.intsance..
  static AuthController instance = Get.find();
  //email, password, name...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  final userRepo = Get.put(StudentController());

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => HomeScreen(email: user.email!));
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account creation failed",
            style: whiteStyle,
          ),
          messageText: Text(e.toString(), style: whiteStyle));
    }
  }

  Future<void> createUser(UserModel userModel) async {
    await userRepo.createUserDataBase(userModel);
    Get.to(() => HomeScreen(email: userModel.email));
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed",
            style: whiteStyle,
          ),
          messageText: Text(e.toString(), style: whiteStyle));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
