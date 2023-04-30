import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import '../utilies/error_show_dialog.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  late Rx<User?> _user;

  User get user => _user.value!;

  Future<void> loginUser(String? email, String? password) async {
    isLoading.value = true;
    try {
      if (email != null && password != null) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Get.snackbar("", "Your'e logged in.");
      }
      Get.offAllNamed(homeRoute);
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        await errorShowDialog("Error: User Not Found");
      } else if (e.code == "wrong-password") {
        await errorShowDialog("Error: Wrong Password");
      } else {
        await errorShowDialog(e.code);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      await errorShowDialog(e.toString());
    }
  }

// User Login session persistance
  @override
  void onReady() {
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(loginRoute);
    } else {
      Get.offAllNamed(homeRoute);
    }
  }
}
